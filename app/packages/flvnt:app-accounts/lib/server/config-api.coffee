
# sets the accounts service config objects from the environ settings
AppAccounts.config.set = (opts) ->
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


AppAccounts.config.exists = (service) ->
  Accounts.loginServiceConfiguration.findOne(service: service)?


AppAccounts.config.insert = (service, appId, clientId, secret, opts) ->
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

