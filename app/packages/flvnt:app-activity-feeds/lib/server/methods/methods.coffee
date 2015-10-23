
Meteor.methods

  notifications_read_at: (read_at)->
    user = ApiUtils.get_meteor_user_or_invalidate()

    query =
      '_id': user._id

    action =
      $set:
        'notification_read_at': read_at

    Meteor.users.update query, action, (err, rv)->
      if err?
        logger.error 'error updating user "notification_read_at":', {
          err: err
          err_stack: err.stack
          user_id: user._id
        }
      else
        logger.info 'notification_read_at updated:', {
          read_at: read_at
          user_id: user._id
        }
