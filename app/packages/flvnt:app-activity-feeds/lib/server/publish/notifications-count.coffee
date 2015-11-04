
#: publish un-read notifications count..
#: see: https://atmospherejs.com/package/publish-counts
Meteor.publish 'NotificationsCount', ->
  @unblock()

  unless @userId?
    logger.info '@userId null in publish: NotificationsCount, returning empty..'
    return @ready()

  user = Meteor.users.findOne '_id': @userId
  query = Activity.query.notifications_count user
  pub = Counts.publish @, 'notifications-count', query, {}

  @ready()
