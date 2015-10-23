
class _AccountSetup

  initialize: ->
    @_in_progress = false
    @completing_account_tracker = new Tracker.Dependency

  set_in_progress: (x)->
    return if @_in_progress == x
    @in_progress = x
    @completing_account_tracker.changed()

  in_progress: ->
    @completing_account_tracker.depend()
    @in_progress


AccountSetup = new _AccountSetup
