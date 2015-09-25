
Meteor.startup ->
  if env.id in ['stage', 'prod', 'local']
    logger.info '[APP-DB-MIGRATIONS] running..'
