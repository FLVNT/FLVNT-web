
AppAccounts.connect_with_service = (service)->
  return if @_logging_in == true
  @_logging_in = true

  args = {}
  args[service] = true
  args.userId = Meteor.userId()

  _callback = =>
    _options = @service_connect_options[service]()
    _handler = Accounts.oauth.credentialRequestCompleteHandler =>
      @_logging_in = null
      @on_connect_with_service service
    Accounts[service].requestCredential _options, _handler

  Accounts.callLoginMethod {
    methodArguments: [args]
    userCallback: _callback
  }


Accounts.ui.loginWithFacebook = (callback)->
  # TODO: force app to get a refreshed access_token ..?
  Meteor.loginWithFacebook(
    AppAccounts.service_connect_options.facebook(), callback)

Accounts.ui.signupWithFacebook = (callback)->
  Meteor.loginWithFacebook(
    AppAccounts.service_connect_options.facebook(), callback)

Accounts.ui.connectWithInstagram = (callback)->
  Meteor.loginWithInstagram(
    AppAccounts.service_connect_options.instagram(), callback)

Accounts.ui.connectWithTwitter = (callback)->
  Meteor.loginWithTwitter(
    AppAccounts.service_connect_options.twitter(), callback)

Accounts.ui.connectWithSoundcloud = (callback)->
  Meteor.loginWithVimeo(
    AppAccounts.service_connect_options.soundcloud(), callback)

Accounts.ui.connectWithVimeo = (callback)->
  Meteor.loginWithVimeo(
    AppAccounts.service_connect_options.vimeo(), callback)

Accounts.ui.connectWithGoogle = (callback)->
  Meteor.loginWithGoogle(
    AppAccounts.service_connect_options.google(), callback)
