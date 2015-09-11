
FLVNTAccountsAccounts = FLVNTAccountsAccounts || {
  ui: {}
  # config is for managing service-configs
  config: {}
}


# sets the accounts service config objects from the environ settings
FLVNTAccountsAccounts.config.set = (opts) ->
  if opts.reset or not @exists "facebook"
    @insert(
      "facebook",
      env.facebook_client_id,
      env.facebook_client_id,
      env.facebook_client_secret,
      opts)

  if opts.reset or not @exists "google"
    @insert(
      "google", null,
      env.google_client_id,
      env.google_client_secret,
      opts)

  if opts.reset or not @exists "soundcloud"
    @insert(
      "soundcloud", null,
      env.soundcloud_client_id,
      env.soundcloud_client_secret,
      opts)


FLVNTAccountsAccounts.config.exists = (service) ->
  Accounts.loginServiceConfiguration.findOne(service: service)?


FLVNTAccountsAccounts.config.insert = (service, appId, clientId, secret, opts) ->
  logger.info "configuring account configration:", service, clientId
  if opts.reset
    Accounts.loginServiceConfiguration.remove {service: service}

  Accounts.loginServiceConfiguration.insert {
    service: service
    appId: appId
    clientId: clientId
    secret: secret
    redirect_uri: env.url "_oauth/#{service}?close"
  }


Meteor.startup ->
  FLVNTAccountsAccounts.config.set reset: false


Meteor.methods
  reset_accounts_config: (reset)->
    logger.info 'updating accounts-ui configuration data..'
    FLVNTAccountsAccounts.config.set reset: true


#
# callback hook when a new user oauths through facebook connect
# todo: investigate pattern here: https://github.com/gadicc/meteor-accounts-merge/blob/master/accounts-merge.js
#
Accounts.onCreateUser (options, user)->
  # logger.info "Accounts.onCreateUser options:", options
  if not user.services.facebook? then return user  # skip other services

  # set the invite_code_id
  #if not options.query.invite_code?.length
  #  throw new Meteor.Error "can't create account without an invite code.."
  #user.invite_code_id = options.query.invite_code

  #logger.info "user connected to facebook:", user.services.facebook, user.invite_code_id
  logger.info "user connected to facebook:", user.services.facebook
  user = UserFacebook.user_account user, options

  # alias the user to mixpanel..
  #if options.query.mp_id?.length
  #  Mp.alias_user options.query.mp_id, user._id

  user


#
# callback hook after onCreateUser is called
#
# multiple providers hack :
# create a user for facebook connections by returning true,
# otherwise, return false so a new user isn't created for
# soundcloud + youtube providers.  then updates the user to
# append initial service data to the user.services[service] document.
#
Accounts.validateNewUser (user)->
  logger.info "Accounts.validateNewUser", "arguments:", arguments

  # todo: how to get request headers in meteor?
  # invite_code_id =

  # is facebook oauth
  if user.services.facebook?
    fbid = user.services.facebook.id
    logger.info "creating new user account.."

    # check for an invite_code_id set from accessing an invite code route,
    # and query for an invitecode to allow the user to create an account
    # if invite_code_id?
    #   return true

    #invite_code = InviteCodes.findOne _id: user.invite_code_id
    #if not invite_code?
    #  logger.warn "invite code not found for the user: #{fbid}"
    #  throw new Meteor.Error "invite code not found for the user: #{fbid}"
    #else
    #  return true

    return true

  else
    # update the user document with the secondary providers.
    FLVNTAccountsAccounts.add_service_connection user, (err, rv) =>
      logger.info "user connected to:", rv.service
      @on_connect_with_service rv

    # return false, since we don't want a new user created for the service
    return false


# copy a service's profile properties and update and existing user doc
FLVNTAccountsAccounts.add_service_connection = (user, callback) ->
  _id = Meteor.userId()
  attrs = {}

  # TODO: migrate to use underscore .find()
  # TODO: where is config.accounts coming from .. ?
  for provider in config.accounts.service_providers
    if user.services[provider]?
      service = provider
      # todo: filter out unnecessary fields
      _.each user.services[service], (value, key)->
        attrs["services.#{service}.#{key}"] = value
      break

  # update the user mongodb document
  Meteor.users.$set _id, attrs

  result = {_id: _id, service: service}

  if callback?
    callback null, result

  else
    result


#
# enqueues a task worker to import the user's service data
#
FLVNTAccountsAccounts.on_connect_with_service = (data) ->
  #JobsAPI.add 'on connect service',
  #  _id: data._id
  #  service: data.service


#
# removes a connected third party service from a user.services document.
#
FLVNTAccountsAccounts.disconnect_service = (service) ->
  attrs = {}
  attrs["services.#{service}"] = ''
  Meteor.users.$unset Meteor.userId(), attrs
  # TODO: revisit
  # JobsAPI.add 'disconnect user from service',
  #   _id: Meteor.userId()
  #   service: service
