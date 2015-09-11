# helpers + utils for meteor api methods
ApiUtils = ApiUtils || {}


# returns a user, or raises if user is not logged in
ApiUtils.get_meteor_user_or_invalidate = ->
  user = Meteor.user()
  if not user?
    throw new Meteor.Error "please login"
  user


# used to throw a Meteor.Error when an argument does not exist or is empty
ApiUtils.validate_non_empty_field_exists = (name, value) ->
  if not value? or _.isEmpty value
    throw new Meteor.Error "#{name} is required and cannot be empty"


ApiUtils.int_or_default = (param, def) ->
  if param?
    param = parseInt param, 10

  else
    param = def

  if isNaN parseInt(param, 10)
    param = def

  param


# handles logging an error + stack trace, raises + bubbles a `Meteor.Error`
# object to the client.
ApiUtils.bubble_api_error = (err, msg) ->
  e = message: msg, err: err.stack
  logger.error e.message, e.stack
  throw new Meteor.Error e


# return a group object, or raises if it does not exist, or user does not
# have sufficient permissions
ApiUtils.get_group_or_invalidate = (group_id, user) ->
  group = Groups.findOne _id: group_id
  if not group? or user._id not in group.member_ids
    rv = message: "user does not have access to the group"
    throw new Meteor.Error rv.message
  group
