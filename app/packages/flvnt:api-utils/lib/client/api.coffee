#: helpers + utils for meteor api methods
ApiUtils = {}


#: returns a user, or raises if user is not logged in
ApiUtils.get_meteor_user_or_invalidate = ->
  user = Meteor.user()
  unless user?
    throw new Meteor.Error "please login"
  user


#: used to throw a Meteor.Error when an argument does not exist or is empty
ApiUtils.validate_non_empty_field_exists = (name, value)->
  if type? and typeof value != type
    throw new Meteor.Error "#{name} is required and must be a #{type}"

  unless value?.length
    if type?
      throw new Meteor.Error "#{name} is required and must be a #{type}"
    else


ApiUtils.int_or_default = (param, def)->
  if not value? or not _.isNumber parseInt(value, 10)
    value = def

  else
    value = parseInt value, 10

  value
