
Activity = new Mongo.Collection "activity", {}


Activity.attachSchema new SimpleSchema

  created_at: SchemaHelpers.created_at()
  updated_at: SchemaHelpers.updated_at()

  published:
    type: Date
    label: "published"

  'actor.url':
    type: String
    label: "actor url"

  'actor.objectType':
    type: String
    label: "actor type"
    allowedValues: ['person']

  'actor.id':
    type: String
    label: "actor id"

  'actor.displayName':
    type: String
    label: "actor display-name"

  'object.url':
    type: String
    label: "object url"

  'object.objectType':
    type: String
    label: "object type"
    allowedValues: ['post', 'group']

  'object.id':
    type: String
    label: "Object id"

  'object.owner_id':
    type: String
    label: "object owner id"

  'object.owner_ids':
    type: [String]
    label: "object owner ids"
    optional: true

  'object.displayName':
    type: String
    label: "object display-name"

  'target.url':
    type: String
    label: "target url"

  'target.objectType':
    type: String
    label: "target type"
    allowedValues: ['group']

  'target.id':
    type: String
    label: "target id"

  'target.displayName':
    type: String
    label: "target display-name"

  'verb':
    type: String
    label: "verb"
    allowedValues: [
      'post', 'play', 'like', 'comment', 'downvote', 'share', 'invite', 'join',
      'delete', 'skip', 'repeat',
    ]


Activity.helpers {}
  route_action: ->
    logger.info '[ROUTE-ACTION]', @, @target, @object
    target_id   = @target?.id
    logger.info 'objectType:', @object.objectType
    logger.info 'target_id:', target_id
    # target_url  = @target?.url
    # target_type = @target?.objectType
    object_id   = @object?.id
    object_url  = @object?.url
    object_type = @object?.objectType
    current_group_id = Session.get 'group_id'

    result = {}

    if object_type == 'post'
      #: TODO: post doc will be null if not in subscription..
      # result.post = Posts.findOne '_id': object_id
      # result.group = result.post.group()

      if current_group_id != target_id
        result.route =
          path: "/group/#{target_id}/#{object_id}"
          post: object_id
          # position: result.post.position
          object_url: object_url

    else if object_type == 'group'
      result.group = Groups.findOne '_id': object_id

      if current_group_id != result.group._id
        result.route =
          path: "/group/#{result.group._id}"
          object_url: object_url

    result


Activity.DEFAULT_PAGE_SIZE = 10


Activity.query =

  feed: (group_id, user_id)->
    or_activities_related_to_my_groups = [
      # the object is related to the group
      {$and: [{'object.objectType': 'group'}, {'object.id': group_id}]},
      # the target is related to the group
      {$and: [{'target.objectType': 'group'}, {'target.id': group_id}]},
    ]

    not_my_activity = 'actor.id': {$ne: user_id}
    query =
      $and: [
        # hide a user's own activity from them
        not_my_activity,
        {$or: or_activities_related_to_my_groups},
      ]
    query


  fb_friend_feed: (user)->
    # todo

  notifications: (user, options)->
    options = options || {}
    result =
      query: {}
      options:
        limit: Activity.DEFAULT_PAGE_SIZE
        sort: {published: -1}

    or_activity_on_owned_objects =
      '$or': [
        # user owns object
        {'object.owner_id': user._id},

        # for is_brand group objects
        {'object.owner_ids': user._id},

        # verb is post and user is in the group
        {$and: [
          {'verb': 'post'},
          {'target.id': {$in: user.group_ids()}},
        ]},
      ]

    # hide a user's own activity from them
    not_my_activity = {'actor.id': {$ne: user._id}}

    result.query.$and = [not_my_activity, or_activity_on_owned_objects]

    result.options.fields =
      '_id': 1
      'published': 1
      'actor.displayName': 1
      'object.displayName': 1
      'object.id': 1
      'object.owner_id': 1
      'object.objectType': 1
      'object.url': 1
      'target.objectType': 1
      'target.id': 1
      'verb': 1

    if options.read_at?
      result.query.$and.push {'published': {$gt: options.read_at}}

    result

  notifications_count: (user)->
    find = Activity.query.notifications user,
      'read_at': user.notification_read_at

    # limit fields to only the _id since we're just running a count..
    find.options.fields =
      '_id': 1

    # logger.info 'notification_count query:', JSON.stringify(find.query)
    # logger.info 'notification_count options:', JSON.stringify(find.options)

    Activity.find find.query, find.options


# sends 'digest' emails based on records in the activity feed..
Activity.send_active_user_digest_emails = (days_back) ->
  #: default to a week
  days_back = 7 unless days_back?

  #: query notifications in the last week
  end = new Date()
  start = new Date()
  start.setDate end.getDate() - days_back

  activities = Activity.find 'published': {$gte: start, $lt: end}
  logger.info 'send notification-digest, raw count:', activities.count()

  #: build notification set for each user
  users = {}

  add_activity_to_user = (user_id, activity) ->
    unless user_id?.length
      # TODO:
      logger.error "activity missing 'owner_id' field:", activity._id

    users[user_id] = [] unless activity[user_id]?
    users[user_id].push activity

  activities.forEach (activity) ->
    # handle likes and comments
    if activity.verb in ['like', 'comment']
      add_activity_to_user activity.object.owner_id, activity

    # handle group activities
    if activity.verb in ['post', 'join']
      group_id = activity.object.id if activity.verb == 'join'
      group_id = activity.target.id if activity.verb == 'post'

      group = Groups.findOne _id: group_id
      member_ids = group.active_member_ids()

      _.each member_ids, (member_id) ->
        add_activity_to_user member_id, activity

  logger.info 'num users with notifications: ', _.keys(users).length

  #: pick relevant data for each user
  for user_id, activities of users
    try
      #: pick tracks
      tracks = _.map activities, (activity) ->
        return if activity.verb == 'join'
        track =
          name: activity.object.displayName
          group_id: activity.target.id

      tracks = _.compact tracks
      tracks = _.uniq tracks
      tracks = tracks[0...5]

      # pick people
      people = _.map activities, (activity) ->
        person =
          name: activity.actor.displayName
          fbid: activity.actor.id

      people = _.uniq people
      people = people[0...5]

      # send
      logger.info 'sending digest notification email:', user_id
      logger.info '- recipient:', user_id
      logger.info '- tracks:', tracks
      logger.info '- users:', people

      if Features.NOTIFICATION_DIGEST.ENABLED_FOR_ADMINS_ONLY
        return unless user_id in env.admins

      Activity.send_digest_email user_id, tracks, people
    catch e
      logger.error e, e.stack


Activity.send_digest_email = (user_id, tracks, people) ->
  user = Meteor.users.findOne '_id': user_id
  return unless user?.emails?[0]?.address?.length

  recipient =
    name: user.profile.name
    email: user.emails[0].address

  logger.info 'sending notification:', recipient, tracks, people

  Meteor.http.post 'http://gae.unvael.com/api/mail/send',
    data:
      recipient: recipient
      template_id: "notifications-digest"
      # todo: replace with https://mixpanel.com/help/reference/http #redirect
      people: people
      tracks: tracks
