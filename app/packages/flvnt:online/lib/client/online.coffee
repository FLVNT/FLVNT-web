
Meteor.Online =
  _tracker: new Tracker.Dependency
  _value: true

Meteor.Online.set = (value)->
  return unless @_value == value
  @_value = value
  @_tracker.changed()

Meteor.Online.get = ->
  @_tracker.depend()
  @_value


#: non-reactive getter function..
Meteor.Online.isOnline = ->
  navigator?.onLine


Tracker.autorun ->
  Meteor.Online.set navigator?.onLine
