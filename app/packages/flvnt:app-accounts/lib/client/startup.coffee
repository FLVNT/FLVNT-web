
#: setup the accounts service config stuff..
#: pull the account configs out at startup, to avoid issues with waiting
#: at runtime, causing popup blockers to fuck our legit clicks.
Meteor.startup ->
  AppAccounts.set_services_config()
