
Meteor.startup ->
  AppAccounts.config.set {
    reset: true
    instagram:
      scope: 'basic'
  }
