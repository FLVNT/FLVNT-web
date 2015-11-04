#: helpers + utils for meteor api methods
ApiUtils = {}


#: returns a user, or raises if user is not logged in
ApiUtils.get_meteor_user_or_invalidate = ->
  user = Meteor.user()
  unless user?
    throw new Meteor.Error "please login"
  user


#: used to throw a Meteor.Error when an argument does not exist or is empty
ApiUtils.validate_non_empty_field_exists = (name, value, type)->
  if type? and typeof value != type
    throw new Meteor.Error "#{name} is required and must be a #{type}"

  unless value?.length
    if type?
      throw new Meteor.Error "#{name} is required and must be a #{type}"
    else
      throw new Meteor.Error "#{name} is required and cannot be empty"


ApiUtils.int_or_default = (value, def)->
  if value?
    value = parseInt value, 10

  else
    value = def

  unless _.isNumber parseInt value, 10
    value = def

  value


#: handles logging an error + stack trace, raises + bubbles a `Meteor.Error`
#: object to the client.
ApiUtils.bubble_api_error = (err, msg)->
  e = message: msg, err: err.stack
  logger.error e.message, e.stack
  throw new Meteor.Error e


#: return a group object, or raises if it does not exist, or user does not
#: have sufficient permissions
ApiUtils.get_group_or_invalidate = (group_id, user)->
  group = Groups.findOne '_id': group_id
  if not group? or user._id not in group.member_ids
    rv = message: "user does not have access to the group"
    throw new Meteor.Error rv.message
  group
