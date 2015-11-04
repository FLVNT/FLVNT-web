
Meteor.publish "userData", ->
  @unblock()

  unless @userId?
    logger.warn '[APP-ACCOUNTS] @userId null in publish: userData, returning empty..'
    return @ready()

  userQuery =
    '_id': @userId

  userOptions =
    fields: Meteor.users.visible_fields()

  logger.info "[APP-ACCOUNTS] publish userData:", @userId
  cursor = Meteor.users.find userQuery, userOptions
  return @ready() unless cursor?

  _ready = false

  handle = cursor.observeChanges {
    added: (_id, fields)=>
      @added 'users', _id, fields

    changed: (_id, fields)=>
      @changed 'users', _id, fields

    removed: (_id)=>
      @removed 'users', _id
  }

  @ready()
  _ready = true

  @onStop =>
    handle.stop()
