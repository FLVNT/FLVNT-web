
Meteor.startup ->
  # logger.info 'MongoInternals:', MongoInternals
  # logger.info 'MongoInternals:', MongoInternals.defaultRemoteCollectionDriver()
  client = MongoInternals.defaultRemoteCollectionDriver().mongo.db

  _connection_error = client.connectionError
  # logger.info '[DEFAULT-REMOTE-COLLECTION-DRIVER]:',
  #   '\n - client.connectionError:', client.connectionError
  #   '\n -', client

  client.connectionError = =>
    logger.warn '[db_client.connectionError]:', arguments
    _connection_error.apply @, arguments
