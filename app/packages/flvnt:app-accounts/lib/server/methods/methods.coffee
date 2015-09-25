
Meteor.methods
  reset_accounts_config: (reset)->
    logger.info 'updating accounts-ui configuration data..'
    AppAccounts.config.set reset: true

