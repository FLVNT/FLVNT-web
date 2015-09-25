
Meteor.methods

  notifications_read_at: (read_at)->
    user = ApiUtils.get_meteor_user_or_invalidate()

    query =
      '_id': user._id

    action =
      $set:
        'notification_click': read_at

    Meteor.users.update query, action
