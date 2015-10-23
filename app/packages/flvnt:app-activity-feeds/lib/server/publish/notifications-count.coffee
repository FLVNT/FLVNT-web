
#: see: https://atmospherejs.com/package/publish-counts
Meteor.publish 'NotificationsCount', ->
  @unblock()

  unless @userId?
    logger.info '@userId null in publish: NotificationCount, returning empty..'
    return @ready()

  #: publish un-read notifications count
  user = Meteor.users.findOne '_id': @userId
  # if user.notification_read_at?
  #   read_at = user.notifications_read_at()
  # else
  #   read_at = null

  pub = Activity.query.notifications_count user
  Counts.publish @, 'notification-count', pub, {}
  @ready()
