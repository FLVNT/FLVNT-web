
# sets the accounts service config objects from the environ settings
AppAccounts.config.set = (opts)->
  if opts.reset or not @exists "facebook"
    @insert(
      "facebook",
      env.facebook_app_id,
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

  if opts.reset or not @exists "instagram"
    @insert(
      "instagram", null,
      env.instagram_client_id,
      env.instagram_client_secret,
      opts)

  if opts.reset or not @exists "twitter"
    @insert(
      "twitter", null,
      env.twitter_client_id,
      env.twitter_client_secret,
      opts)

  if opts.reset or not @exists "vimeo"
    @insert(
      "vimeo", null,
      env.vimeo_client_id,
      env.vimeo_client_secret,
      opts)

  if opts.reset or not @exists "snapchat"
    @insert(
      "snapchat", null,
      env.snapchat_client_id,
      env.snapchat_client_secret,
      opts)


AppAccounts.config.exists = (service) ->
  Accounts.loginServiceConfiguration.exists 'service': service


AppAccounts.config.insert = (service, appId, clientId, secret, opts) ->
  logger.info "configuring account configration:", service, clientId
  Accounts.loginServiceConfiguration.remove('service': service) if opts.reset

  doc =
    service  : service
    appId    : appId
    secret   : secret
    clientId : clientId
    redirect_uri : env.url "_oauth/#{service}?close"

  if opts[service]?.scope?
    doc.scope = opts.scope

  Accounts.loginServiceConfiguration.insert doc

