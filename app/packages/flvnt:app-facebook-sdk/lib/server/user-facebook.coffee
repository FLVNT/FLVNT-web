
class UserFacebook

  #: configure a user's profile and account from their facebook identity
  @user_account: (user, options)->
    #: make facebook api request + merge fb fields onto user profile..
    identity = FLVNT_FB.getIdentity user

    unless user.services?.facebook?.id?.length
      throw new Meteor.Error("error configuring account from facebook for user: #{user._id}")

    #: set the _id to the facebook user id
    user._id = user.services.facebook.id

    # flag to determine that the user has not completed the setup of their
    # account..
    user.completed_setup = false
    user.profile = options.profile

    _flatten_set = (field)->
      return unless identity[field]?
      _.map _.pairs(identity[field]), (pair)->
        key = field + '_' + pair[0]
        user.services.facebook[key] = pair[1]
      delete user.services.facebook[field]

    _set = (fields)->
      _.map fields, (field)->
        if identity[field]?
          user.services.facebook[field] = identity[field]

    _set [
      'birthday', 'bio', 'devices', 'education', 'interested_in', 'languages',
    ]

    _flatten_set 'age_range'  # flatten the age range field
    _flatten_set 'location'  # flatten the location field

    #: set data import counter defaults
    # user.services.facebook.friends_imported = 0
    # user.services.facebook.music_likes_imported = 0
    # user.services.facebook.friends_music_likes_imported = []
    # user.services.facebook.friends_music_likes_import_failures = []

    #: remove fields that we've mapped to profile fields..
    _remove_mapped_fields = (user)->
      _.map ['name', 'first_name', 'last_name', 'languages', 'location', 'age_range'], (f)->
        try
          if user.services.facebook[f]?
            delete user.services.facebook[f]
        catch e
          # pass..

    _remove_mapped_fields()

    # TODO:  optional feature to add in an email verification step..
    email_verified = true

    user.emails = [
      address: user.services.facebook.email
      verified: email_verified
    ]

    user


  @download_fbfriends: (user)->
    logger.info "downloading fb friends for: #{user._id}.."

    try
      friends = FLVNT_FB.getFriends(user).data
      logger.info "#{friends.length} friends downloaded for: #{user._id}.."
    catch err
      logger.error "downloading fb-friends for: #{user._id} failed..", {
        user_fbid: user._id
        user_name: user.profile.name
        user_email: user.emails[0]?.address
        err: e
        err_stack: err.stack
      }

    return unless friends?.length

    try
      selector =
        '_id': user._id

      action =
        $set:
          'user_id': user._id
        $addToSet:
          'friends':
            $each: friends
      FBFriends.upsert selector, action
    catch e
      logger.error "upserting fb-friends for: #{user._id} failed..", {
        user_fbid: user._id
        user_name: user.profile?.name
        user_email: user.emails[0]?.address
        facebook: user.services?.facebook
        err: e
        err_stack: e.stack
      }
