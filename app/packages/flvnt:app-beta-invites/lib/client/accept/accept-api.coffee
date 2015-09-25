
class @InviteAccept

  initialize: ->
    @_in_progress = false
    @_tracker_deps = new Tracker.Dependency

  set_in_progress: (x)->
    if @_in_progress is not x
      @in_progress = x
      @_tracker_deps.changed()

  in_progress: ->
    @_tracker_deps.depend()
    @in_progress
