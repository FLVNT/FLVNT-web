
FLVNTAccounts = FLVNTAccounts || {
  ui: {}
  # config is for managing service-configs
  config: {}
}


Meteor.startup ->

  # set the Accounts[service] convention for builtin packages..
  Accounts.google = Package.google.Google
  Accounts.facebook = Package.facebook.Facebook

  # initialize the accounts-ui package
  Accounts.ui?.config config.accounts.ui

