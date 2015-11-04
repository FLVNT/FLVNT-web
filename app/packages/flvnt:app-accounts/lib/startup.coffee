
Meteor.startup ->
  #: initialize the accounts-ui package
  Accounts.ui?.config AppAccounts.config.ui
