
#: init the accounts service config..
Meteor.startup ->

  Tracker.autorun ->
    Accounts.service_config = {}
    for ser in Accounts.loginServiceConfiguration.find().fetch()
      Accounts.service_config[ser.service] = ser

  #: TODO: BROKEN
  # AppAccounts.init()
