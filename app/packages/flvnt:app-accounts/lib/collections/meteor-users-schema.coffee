# see: https://github.com/aldeed/meteor-collection2/blob/master/README.md#attaching-a-schema-to-a-collection

Meteor.users.attachSchema new SimpleSchema

  createdAt:
    type: Date
    label: "created at"
    optional: true

  updated_at: SchemaHelpers.updated_at()

  notifications_read_at:
    type: Date
    label: "notifications-read-at date"
    optional: true

  completed_setup:
    type: Boolean
    label: "completed setup"
    optional: true

  profile:
    # TODO: define as sub-schema for profile..
    type: Object
    label: "user profile"
    blackbox: true
    optional: true

  services:
    # TODO: define as sub-schema for services.
    type: Object
    label: "user accounts services"
    blackbox: true
    optional: true

  invite_code_id:
    type: String
    label: "invite-code-id"
    optional: true

  'groups.id':
    type: String
    label: "group id"
    optional: true

  'groups.status':
    type: String
    label: "group status"
    optional: true

  'groups.admin':
    type: Boolean
    label: "group admin"
    optional: true

  'emails.$.address':
      type: String
      label: "email address"
      optional: true

  'emails.$.verified':
      type: Boolean
      label: "verified"
      optional: true

  'stats.comments':
      type: Number
      label: "comments count"
      min: 0
      optional : true

  'stats.posts':
      type: Number
      label: "posts count"
      min: 0
      optional : true

  'stats.likes':
      type: Number
      label: "likes count"
      min: 0
      optional : true

  # TODO: deprecate, migrate -> stats.down
  'stats.downvotes':
      type  : Number
      label : "downvotes count"
      min   : 0
      optional : true


Meteor.users.helpers
  fb_graph_photo: (width)->
    _id = @_id
    size = "type=large"
    if width?
      size = "width=#{width}"
    "http://graph.facebook.com/#{_id}/picture?#{size}"

  # returns a string list of ids that the user belongs to
  group_ids: ->
    _.pluck @groups, 'id'

  parseEmail: ->
    if not @emails? and @services
      email = switch
        when services.facebook then services.facebook.email
        when services.github   then services.github.email
        when services.google   then services.google.email
        when services.twitter  then null
        else null
      email

  #: updates the user document..
  set_notifications_read_at: (read_at)->
    user = ApiUtils.get_meteor_user_or_invalidate()

    query =
      '_id': user._id

    action =
      $set:
        'notifications_read_at': read_at

    Meteor.users.update query, action, (err, rv)->
      if err?
        logger.error 'error updating user "notifications_read_at":', {
          err: err
          err_stack: err.stack
          user_id: user._id
        }
      else
        logger.info 'notifications_read_at updated:', {
          read_at: read_at
          user_id: user._id
        }

  #: called after a user confirms their invite and sets their email + password
  complete_account_setup: (options)->
    return unless Meteor.isServer
    user = options.user

    #: enqueue a task worker to import the user's facebook data
    # JobsAPI.add 'on create new user',
    #   _id: user._id
    #   fbid: user.services.facebook.id
    #   access_token: user.services.facebook.accessToken

    if user.completed_setup == true
      throw new Meteor.Error(
        "#{user.profile.name} (id: #{user._id}, email: #{options.email}) " +
        "has already completed account setup.")

    ApiUtils.validate_non_empty_field_exists 'name', options.name
    ApiUtils.validate_non_empty_field_exists 'email', options.email
    ApiUtils.validate_non_empty_field_exists 'password', options.password

    # TODO:  optional feature to add in an email verification step
    options.verified = true

    update =
      $set:
        'completed_setup': true
        'profile.name': options.name
        'subsciptions.email': true
      $addToSet:
        'emails':
          'address': options.email
          'verified': options.verified
    Meteor.users.update user._id, update

    #: use the accounts-password built-in method to set the password + salt..
    Accounts.setPassword user._id, options.password

    #: download facebook friend data
    #: TODO: move back to background jobs..
    UserFacebook.download_fbfriends user

    # #: create default ShepherdTour docs
    # if Features.ENABLE_SHEPHERD
    #   ShepherdTours.new_user_signup user._id


Meteor.users.allow
  # TODO: this might be broken!!
  # allow users to edit their `notifications_read_at`
  update: (userId, doc, fields, modifier)->
    # deny users editing other users
    return false unless doc._id == userId

    allow = (
      ( fields?.length == 1 )                 and
      ( fields[0] == 'notifications_read_at'  )  and
      ( modifier.$set?.notifications_read_at? )  and
      ( _.isDate modifier.$set.notifications_read_at )
    )

    logger.info '[USERS-UPDATE-ALLOW] notifications_read_at:', allow
    allow
  ,
  fetch: ['_id']


# some short-hand helpers..

Meteor.users.$unset = (_id, attrs)->
  Meteor.users.update _id, {$unset: attrs}


Meteor.users.$set = (_id, attrs)->
  Meteor.users.update _id, {$set: attrs}


#: TODO: come up with a nity way for other packages to "register" fields to be
#: included in the publish..
Meteor.users.visible_fields = ->
  'createdAt'       : 1
  'completed_setup' : 1
  'profile.name'    : 1
  'notifications_read_at' : 1

  'stats.posts' : 1
  'stats.likes' : 1
  'stats.down'  : 1

  'groups.id'     : 1
  'groups.admin'  : 1
  'groups.status' : 1

  #: facebook fields autopublished by accounts-facebook package
  #: TODO: why gender..?  contribute a change to meteor-core to remove it ?
  #: ---------------
  # 'services.facebook.id': 1
  # 'services.facebook.username': 1
  # 'services.facebook.gender': 1

  #: facebook fields
  #: ---------------
  # 'services.facebook.bio': 1
  # 'services.facebook.birthday': 1
  # 'services.facebook.email': 1
  # 'services.facebook.expiresAt': 1
  # 'services.facebook.link': 1
  # 'services.facebook.locale': 1
  # 'services.facebook.location': 1
  # 'services.facebook.music.data': 1

  # google fields
  # -------------
  # 'services.google.expiresAt': 1
  # 'services.google.id': 1
  # 'services.google.picture': 1

  # soundcloud fields
  # -----------------
  # 'services.soundcloud.avatar_url': 1
  # 'services.soundcloud.city': 1
  # 'services.soundcloud.country': 1
  # 'services.soundcloud.description': 1
  # 'services.soundcloud.followers_count': 1
  # 'services.soundcloud.followings_count': 1
  # 'services.soundcloud.id': 1
  # 'services.soundcloud.permalink_url': 1
  # 'services.soundcloud.playlist_count': 1
  # 'services.soundcloud.private_playlists_count': 1
  # 'services.soundcloud.private_tracks_count': 1
  # 'services.soundcloud.public_favorites_count': 1
  # 'services.soundcloud.track_count': 1
  # 'services.soundcloud.website': 1
  # 'library.soundcloud_favorite_ids': 1


Meteor.users.helpers
  validate_fb_token: ->
    if not user.services?.facebook? or not user.services.facebook.accessToken?.length
      logger.warn("user #{user._id} doesn't have their facebook connected..")
      return false

    #: check + return if we're aware that the user's fb-auth-token is expired..
    if user.services.facebook._expired == 1
      logger.warn("user #{user._id}'s auth token is still expired..")
      return false

    #: check that the auth token has not expired...
    #: TODO: if it has, set a property on the user-document or a new document
    #: collection so we can re-engage "stale" users..
    if user.services.facebook.expiresAt?.length
      expires_at = user.services.facebook.expiresAt
      #: currently saved as a string coming back from facebook-api..
      if _.isString user.services.facebook.expiresAt
        expires_at = parseInt(user.services.facebook.expiresAt, 10)

      expires_at_date = new Date(expires_at)
      now = (new Date())
      if now > expires_at_date
        logger.warn("user #{user.services.facebook.username}(id: #{user._id})'s fb-auth-token expired: #{expires_at_date}")

        #: for now, update the user document to skip being re-run in task..
        query =
          '_id': user._id
        action =
          $set:
            'services.facebook._expired': 1
        Meteor.users.update selector, action
        return false

    true

