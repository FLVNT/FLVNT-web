
Meteor.startup ->
  # logger.info 'MongoInternals:', MongoInternals
  # logger.info 'MongoInternals:', MongoInternals.defaultRemoteCollectionDriver()
  db_client = MongoInternals.defaultRemoteCollectionDriver().mongo.db

  _connection_error = db_client.connectionError
  logger.info 'db_client:', db_client

  db_client.connectionError = =>
    logger.warn '[db_client.connectionError]:', arguments
    _connection_error.apply @, arguments
