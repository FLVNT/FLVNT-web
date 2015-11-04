
#: NOTE: this is set here to provide server-side code access to the account-ui
#: config object

AppAccounts.config.service_providers = [
  'google',
  'soundcloud',
  'instagram',
  'twitter',
  'vimeo',
  'facebook',
  'snapchat',
]

AppAccounts.config.ui =
  passwordSignupFields: "USERNAME_AND_EMAIL"
  #: only required by google (for now)..
  requestOfflineToken: {google: true}
