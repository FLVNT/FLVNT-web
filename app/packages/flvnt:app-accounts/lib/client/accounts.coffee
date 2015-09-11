
FLVNTAccountsAccounts = FLVNTAccountsAccounts || {
  ui: {}
  # config is for managing service-configs
  config: {}
}


# setup the accounts service config stuff..
Meteor.startup ->
  Tracker.autorun ->
    Accounts.service_config = {}
    for ser in Accounts.loginServiceConfiguration.find().fetch()
      Accounts.service_config[ser.service] = ser

  # BROKEN!!
  #FLVNTAccountsAccounts.init()


### BROKEN!!
# init accounts: load accounts-services-configuration
FLVNTAccountsAccounts.init = ->
  console.log 'rhoner 3'
  @_service_config_handle = Accounts.connection.subscribe "meteor.loginServiceConfiguration"
  Meteor.setTimeout (=>
    if @_service_config_handle.ready()
      @_set_accounts_services_config()
    else
      @init()
  ), 25

# pull the account configs out at startup, to avoid issues with waiting
# at runtime, causing popup blockers to fuck our legit clicks.
FLVNTAccountsAccounts._set_accounts_services_config = ->
  Accounts.service_config = {}
  for ser in Accounts.loginServiceConfiguration.find().fetch()
    Accounts.service_config[ser.service] = ser

  # once set, unsubscribe..
  @_service_config_handle.stop()
  @_service_config_handle = null
###


Accounts.ui.loginWithFacebook = (callback)->
  # TODO: force app to get a refreshed access_token
  Meteor.loginWithFacebook(
    FLVNTAccountsAccounts.service_connect_options.facebook(), callback)

Accounts.ui.connectWithFacebook = (callback)->
  Meteor.loginWithFacebook(
    FLVNTAccountsAccounts.service_connect_options.facebook(), callback)


#
# multiple providers hack :
# defines methods that hook into FLVNTAccounts's custom flow for multiple
# oauth provider service connections
#

FLVNTAccountsAccounts.service_connect_options =
  facebook: (opts) ->
    rv = _.extend {}, Accounts.service_config.facebook
    rv.requestPermissions = Accounts.ui._options.requestPermissions.facebook
    rv.generateLoginToken = true

    # chrome bug: https://github.com/meteor/meteor/issues/1004#issuecomment-68652474
    # UA in Chrome iOS is same as Safari iOS, with CriOS/<ChromeRevision> addition
    if BrowserDetect.OS == 'iPhone/iPod'
      if BrowserDetect.browser == 'Chrome' or navigator.userAgent.indexOf('CriOS') != -1
        rv.loginStyle = 'redirect'

    ###
    # append the invite code, so we can access it from within the oauth
    # callback to validate a user account creation
    code = Session.get 'invite_code_id'
    if code?.length and $.trim(code).length
      rv.redirect_uri += "&invite_code=#{code}"

    # pass mixpanel's distinct id through the oauth flow, so we have a chance
    # to alias user at earliest possible moment (we obtain the user's FBID)
    mp_id = mixpanel.get_distinct_id()
    if mp_id?.length
      rv.redirect_uri += "&mp_id=#{mp_id}"

    rv.redirect_uri = escape "#{rv.redirect_uri}"
    logger.info 'redirect_uri:', rv.redirect_uri
    ###

    # override with the passed in options
    _.extend(rv, opts) if opts?
    rv

  google: ->
    rv = _.extend {}, Accounts.service_config.google
    rv.requestPermissions = Accounts.ui._options.requestPermissions.google
    rv.generateLoginToken = false
    rv

  soundcloud: ->
    rv = _.extend {}, Accounts.service_config.soundcloud
    rv.generateLoginToken = false
    rv


FLVNTAccountsAccounts.connect_with_service = (service)->
  args = {}
  args[service] = true
  args.userId = Meteor.userId()

  callback = =>
    options = @service_connect_options[service]()
    handler = Accounts.oauth.credentialRequestCompleteHandler =>
      @on_connect_with_service service
    Accounts[service].requestCredential options, handler

  Accounts.callLoginMethod {
    methodArguments: [args]
    userCallback: callback
  }


# callback when a user successfuly connected with a third-party oauth provider
FLVNTAccountsAccounts.on_connect_with_service = (service)->
  logger.info "connected to service:", service
  u = Meteor.user()
  logger.info "on_connect_with_service:", service, u
  # todo: move logic from RouteController to here..


# callback when a user disconnected a third-party oauth provider account
FLVNTAccountsAccounts.disconnect_service = (service)->
  logger.info 'disconnecting from service:', service
  Meteor.call 'disconnect_service', service, (err, result) =>
    if err?
      logger.warn 'error disconnecting service:', err

    else
      logger.info 'service disconnect callback'


# callback to be called after a login attempt succeeds
Accounts.onLogin ->
  logger.info 'accounts-callback-hook: on-login'


# callback to be called after the login has failed
Accounts.onLoginFailure ->
  logger.warn 'accounts-callback-hook: on-login-failure'
