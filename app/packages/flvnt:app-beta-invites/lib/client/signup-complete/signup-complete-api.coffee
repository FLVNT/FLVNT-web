
class @InviteSignupComplete

  initialize: ->
    @_in_progress = false
    @completing_account_deps = new Tracker.Dependency

  set_in_progress: (x)->
    if @_in_progress is not x
      @in_progress = x
      @completing_account_deps.changed()

  in_progress: ->
    @completing_account_deps.depend()
    @in_progress


  #: callback when a user successfully completes creating and setting up their
  #: account (from an InviteCode). redirects user the `groups/new`
  on_signup_complete: ->
    #: TODO: currently the router will redirect the user, but let's invoke here
    #: for now to see which runs first, and if this will be faster than waiting
    #: for the router to re-run the controller's `before` call.
    logger.info 'account setup complete.'

    Mp.track_facebook_signup 'invite-code-id': Session.get('accept_invite_code_id')

    # signin event tracked in user accounts callback hook..
    # Mp.track_signin()

    Session.set 'user_completed_setup', true
