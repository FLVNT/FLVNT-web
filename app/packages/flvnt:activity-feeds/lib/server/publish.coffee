
# see: https://atmospherejs.com/package/publish-counts
Meteor.publish 'NotificationCount', ->
  @unblock()

  if not @userId?
    logger.info '@userId null in publish: NotificationCount, returning empty..'
    return @ready()

  # publish un-read notifications count
  user = Meteor.users.findOne '_id': @userId
  # if user.notification_click?
  #   read_at = user.notifications_read_at()
  # else
  #   read_at = null

  pub = Activity.query.notifications_count user
  Counts.publish @, 'notification-count', pub, {}
  return @ready()


Meteor.publish "Notifications", (num_visible)->
  @unblock()

  if not @userId?
    logger.info '@userId null in `Notifications` publish: returning empty..'
    return @ready()

  if not num_visible? or not isNaN parseInt(num_visible)
    num_visible = Activity.DEFAULT_PAGE_SIZE

  user = Meteor.users.findOne _id: @userId
  find = Activity.query.notifications user
  find.options.limit = num_visible

  pub = Activity.find find.query, find.options
  # logger.info 'publishing Notifications:', pub.count()
  return @ready() if not pub?
  pub
