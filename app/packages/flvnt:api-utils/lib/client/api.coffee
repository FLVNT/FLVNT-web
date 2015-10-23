#: helpers + utils for meteor api methods
ApiUtils = {}


#: returns a user, or raises if user is not logged in
ApiUtils.get_meteor_user_or_invalidate = ->
  user = Meteor.user()
  unless user?
    throw new Meteor.Error "please login"
  user


#: used to throw a Meteor.Error when an argument does not exist or is empty
ApiUtils.validate_non_empty_field_exists = (name, value) ->
  unless value?.length
    throw new Meteor.Error "#{name} is required and cannot be empty"


ApiUtils.int_or_default = (param, def) ->
  if not param? or _.isNaN(parseInt(param, 10))
    param = def

  else
    param = parseInt param, 10

  param
