
activity_api = {}


DEFAULT_ACTOR_NAME = 'someone'


# private methods
# -----------------------------------------------------------------------------

#: returns string of absolute url to user's profile
activity_api._actor_url = (user) ->
  Meteor.absoluteUrl "user/#{user._id}"

#: returns string of absolute url to track post within a group
activity_api._post_url = (post) ->
  Meteor.absoluteUrl "group/#{post.group_id}/#{post._id}"

#: returns string of absolute url to a group
activity_api._group_url = (group) ->
  Meteor.absoluteUrl "group/#{group._id}"


#: returns an `actor` object parsed from a `Meteor.user` doc
activity_api._actor = (user) ->
  actor_name = user.profile?.name
  actor_name = DEFAULT_ACTOR_NAME unless actor_name?.length

  actor =
    url: @_actor_url user
    objectType: "person"
    id: user._id
    displayName: actor_name
  actor

#: returns an `actor` object
activity_api._invitee_object = (user) ->
  actor_name = user?.name
  actor_name = DEFAULT_ACTOR_NAME unless actor_name?.length

  actor =
    url: @_actor_url user
    objectType: "person"
    displayName: actor_name
  actor

# returns an activity object parsed from a `Group` doc
activity_api._group_object = (group) ->
  object =
    url: @_group_url group
    objectType: "group"
    id: group._id
    owner_id: group.owner_id
    owner_ids: group.admin_ids()
    displayName: group.name
  object

#: returns an activity object parsed from a `Post` doc
activity_api._post_object = (post, track) ->
  object =
    url: @_post_url post
    objectType: "post"
    id: post._id
    owner_id: post.user_id
    displayName: post.track_title()
  object


activity_api._insert = (activity) ->
  try
    _id = Activity.insert activity
    logger.info "activity created {_id: #{_id}}"
    _id
  catch e
    logger.warn 'error inserting activity:', e, e.stack


activity_api._create = (verb, user) ->
  activity =
    published: new Date()
    verb: verb
    actor: @_actor user
  activity


# public methods
# -----------------------------------------------------------------------------

activity_api.create_group = (group_id, user) ->
  group = Groups.findOne '_id': group_id

  activity = @_create 'group', user
  activity.object = @_group_object group
  activity.target = @_group_object group
  # activity.text = "posted #{track.title}"

  @_insert activity


activity_api.create_track_post = (post_id, user) ->
  post = Posts.findOne '_id': post_id
  return logger.warn("[ACTIVITY-API]create_track_post: post not found: #{post_id}") unless post?
  track = post.track()
  return logger.warn("[ACTIVITY-API]create_track_post: library-track not found: {_id: #{post.library_id}}") unless track?
  group = post.group()

  activity = @_create 'post', user
  activity.object = @_post_object post, track
  activity.target = @_group_object group
  # activity.text = "posted #{track.title}"

  @_insert activity


activity_api.delete_track_post = (post_id, user) ->
  post = Posts.findOne '_id': post_id
  track = post.track()
  group = post.group()

  activity = @_create 'delete', user
  activity.object = @_post_object post, track
  activity.target = @_group_object group
  # activity.text = "favorited #{track.title}"

  @_insert activity


activity_api.play_track = (post_id, user) ->
  return unless user?
  post = Posts.findOne '_id': post_id
  track = post.track()
  group = post.group()

  activity = @_create 'play', user
  activity.object = @_post_object post, track
  activity.target = @_group_object group
  # activity.text = "favorited #{track.title}"

  @_insert activity


activity_api.share_track = (post_id, user) ->
  return unless user?
  post = Posts.findOne '_id': post_id
  track = post.track()
  group = post.group()

  activity = @_create 'share', user
  activity.object = @_post_object post, track
  activity.target = @_group_object group
  # activity.text = "favorited #{track.title}"

  @_insert activity


activity_api.like_track = (post_id, user) ->
  post = Posts.findOne '_id': post_id
  track = post.track()
  group = post.group()

  activity = @_create 'like', user
  activity.object = @_post_object post, track
  activity.target = @_group_object group
  # activity.text = "favorited #{track.title}"

  @_insert activity


activity_api.skip_post = (post_id, user) ->
  post  = Posts.findOne '_id': post_id
  track = post.track()
  group = post.group()

  activity = @_create 'skip', user
  activity.object = @_post_object post, track
  activity.target = @_group_object group
  # activity.text = "downvoted #{track.title}"

  @_insert activity


activity_api.downvote_post = (post_id, user) ->
  post  = Posts.findOne '_id': post_id
  track = post.track()
  group = post.group()

  activity = @_create 'downvote', user
  activity.object = @_post_object post, track
  activity.target = @_group_object group
  # activity.text = "downvoted #{track.title}"

  @_insert activity


activity_api.comment_post = (post_id, user) ->
  post = Posts.findOne '_id': post_id
  track = post.track()
  group = post.group()

  activity = @_create 'comment', user
  activity.object = @_post_object post, track
  activity.target = @_group_object group
  # activity.text = "commented on #{track.title}"

  @_insert activity


activity_api.invite_to_group = (group_id, user, invitee) ->
  group = Groups.findOne '_id': group_id

  activity = @_create 'invite', user
  activity.object = @_group_object group
  activity.target = @_invitee_object invitee
  # activity.text = "invited #{invitee.name} to #{group.name}"

  @_insert activity


activity_api.join_group = (group_id, user) ->
  group = Groups.findOne '_id': group_id

  activity = @_create 'join', user
  activity.object = @_group_object group
  # activity.text = "joined #{group.name}"

  @_insert activity
