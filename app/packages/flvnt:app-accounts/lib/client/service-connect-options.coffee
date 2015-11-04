
#: multiple providers hack
#: -----------------------
#: defines methods that hook into AppAccounts's custom flow for multiple
#: oauth provider service connections
AppAccounts.service_connect_options =
  facebook: (opts)->
    rv = _.extend {}, AppAccounts.service_config.facebook
    rv.requestPermissions = AppAccounts.config.ui.requestPermissions.facebook
    rv.generateLoginToken = true   #: true for FB..

    #: chrome bug: https://github.com/meteor/meteor/issues/1004#issuecomment-68652474
    #: UA in Chrome iOS is same as Safari iOS, with CriOS/<ChromeRevision> addition
    if BrowserDetect.OS == 'iPhone/iPod'
      if BrowserDetect.browser == 'Chrome' or navigator.userAgent.indexOf('CriOS') != -1
        rv.loginStyle = 'redirect'

    ###
    #: append the invite code, so we can access it from within the oauth
    #: callback to validate a user account creation
    code = Session.get 'invite_code_id'
    if code?.length and $.trim(code).length
      rv.redirect_uri += "&invite_code=#{code}"

    #: pass mixpanel's distinct id through the oauth flow, so we have a chance
    #: to alias user at earliest possible moment (we obtain the user's FBID)
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
    rv = _.extend {}, AppAccounts.service_config.google
    # rv.requestPermissions = Accounts.ui._options.requestPermissions.google
    rv.requestPermissions = AppAccounts.config.ui.requestPermissions.google
    rv.generateLoginToken = false
    rv

  soundcloud: ->
    rv = _.extend {}, AppAccounts.service_config.soundcloud
    rv.requestPermissions = AppAccounts.config.ui.requestPermissions.soundcloud
    rv.generateLoginToken = false
    rv

  instagram: ->
    rv = _.extend {}, AppAccounts.service_config.instagram
    rv.requestPermissions = AppAccounts.config.ui.requestPermissions.instagram
    rv.generateLoginToken = false
    rv

  twitter: ->
    rv = _.extend {}, AppAccounts.service_config.twitter
    rv.requestPermissions = AppAccounts.config.ui.requestPermissions.twitter
    rv.generateLoginToken = false
    rv

  vimeo: ->
    rv = _.extend {}, AppAccounts.service_config.vimeo
    rv.requestPermissions = AppAccounts.config.ui.requestPermissions.vimeo
    rv.generateLoginToken = false
    rv

  snapchat: ->
    rv = _.extend {}, AppAccounts.service_config.snapchat
    rv.requestPermissions = AppAccounts.config.ui.requestPermissions.snapchat
    rv.generateLoginToken = false
    rv
