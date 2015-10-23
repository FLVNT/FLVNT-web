
#: callback to be called after a login attempt succeeds
Accounts.onLogin ->
  AppAccounts._logging_in = null

#: callback to be called after the login has failed
Accounts.onLoginFailure ->
  AppAccounts._logging_in = null


#: callback when a user successfuly connected with a third-party oauth provider
AppAccounts.on_connect_with_service = (service)->
  logger.info "connected to service:", service
  u = Meteor.user()
  logger.info "on_connect_with_service:", service, u
  # todo: move logic from RouteController to here..


#: callback when a user disconnected a third-party oauth provider account
AppAccounts.disconnect_service = (service)->
  logger.info 'disconnecting from service:', service
  Meteor.call 'disconnect_service', service, (err, result) =>
    if err?
      logger.warn 'error disconnecting service:', err

    else
      logger.info 'service disconnect callback'
