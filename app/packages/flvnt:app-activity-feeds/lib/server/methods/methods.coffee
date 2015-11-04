
Meteor.methods

  set_notifications_read_at: (read_at)->
    user = ApiUtils.get_meteor_user_or_invalidate()
    user.set_notifications_read_at read_at
