
Meteor.publish "Notifications", (num_visible)->
  @unblock()

  unless @userId?
    logger.info '@userId null in `Notifications` publish: returning empty..'
    return @ready()

  if not num_visible? or not isNaN parseInt(num_visible)
    num_visible = Activity.DEFAULT_PAGE_SIZE

  user = Meteor.users.findOne _id: @userId
  find = Activity.query.notifications user
  find.options.limit = num_visible

  pub = Activity.find find.query, find.options
  # logger.info 'publishing Notifications:', pub.count()
  return @ready() unless pub?
  pub
