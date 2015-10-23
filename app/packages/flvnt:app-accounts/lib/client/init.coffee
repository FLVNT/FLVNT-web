
AppAccounts.set_services_config = ->
  @service_config ?= {}

  Meteor.setTimeout (=>
    unless Accounts.loginServiceConfiguration?
      return AppAccounts.set_services_config()

    for service_cfg in Accounts.loginServiceConfiguration.find().fetch()
      @service_config[service_cfg.service] = service_cfg
  ), 50
