# see: https://github.com/aldeed/meteor-collection2/blob/master/README.md#attaching-a-schema-to-a-collection

Meteor.users.attachSchema new SimpleSchema

  createdAt:
    type: Date
    label: "created at"
    optional: true

  updated_at: SchemaHelpers.updated_at()

  notifications_read_at:
    type: Date
    label: "notification read-at date"
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

  'stats.downvotes':
      type  : Number
      label : "downvotes count"
      min   : 0
      optional : true


Meteor.users.helpers
  fb_graph_photo: (width) ->
    _id = @_id
    size = "type=large"
    if width?
      size = "width=#{width}"
    "http://graph.facebook.com/#{_id}/picture?#{size}"

  # returns a string list of ids that the user belongs to
  group_ids: ->
    _.pluck @groups, 'id'

  parseEmail: ->
    if @emails

    else if @services
      email = switch
        when services.facebook then services.facebook.email
        when services.github   then services.github.email
        when services.google   then services.google.email
        when services.twitter  then null
        else null
      email

  notifications_read_at: (read_at) ->
    unless read_at?.valueOf?
      if @notification_read_at?
        read_at = @notification_read_at

    unless read_at?.valueOf?
      read_at = new Date 1970, 1, 1

    if _.isString read_at
      read_at = new Date read_at

    read_at

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

    # use the accounts-password built-in method to set the password + salt
    Accounts.setPassword user._id, options.password

    # download facebook friend data
    # TODO: move back to background jobs..
    UserFacebook.download_fbfriends user

    # create default ShepherdTour docs
    if Features.ENABLE_SHEPHERD
      ShepherdTours.new_user_signup user._id


Meteor.users.allow
  # TODO: this might be broken!!
  # allow users to edit their notification read_at marker
  update: (userId, doc, fields, modifier) ->
    # deny users editing other users
    return false unless doc._id == userId

    allow = (
      ( fields?.length == 1 )                 and
      ( fields[0] == 'notification_read_at'  )  and
      ( modifier.$set?.notification_read_at? )  and
      ( _.isDate modifier.$set.notification_read_at )
    )

    logger.info '[USERS-UPDATE] allow', allow
    allow
  ,
  fetch: ['_id']


# some short-hand helpers..

Meteor.users.$unset = (_id, attrs)->
  Meteor.users.update _id, {$unset: attrs}


Meteor.users.$set = (_id, attrs)->
  Meteor.users.update _id, {$set: attrs}
