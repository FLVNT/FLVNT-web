
# manage state of the view from reactive dependencies
Tracker.autorun ->
  if Session.get('signup_completed')?
    if Session.get('signup_completed') is true
      Session.set 'signup_completed', null
      Router.go Router.path('groups/100')

    if invite_signup_complete.in_progress()
      $('#invite-signup-complete').css opacity: 0.35
    else
      $('#invite-signup-complete').css opacity: 1


Template['invite-signup-complete'].helpers
  vimeo_url: ->
    videoid = "110487652"
    "//player.vimeo.com/video/#{videoid}?title=0&amp;byline=0&amp;portrait=0&amp;autoplay=1&amp;loop=1"

  # reactive data helper for a new user account that has connected via
  # facebook, but hasn't yet completed their account setup.
  user: ->
    Meteor.user()


Template['invite-signup-complete'].created = ->
  Session.set 'signup_completed', false


Template['invite-signup-complete'].rendered = ->
  $('html, body').addClass 'login-screen'
  @autorun =>
    # we populate the name and email fields from facebook, so set initial focus
    # on the password field and init the bootstrap popover
    $field = Template.instance().$ 'input[name="email"]'
    $field.popover('toggle').focus().select()


Template['invite-signup-complete'].destroyed = ->
  $('html, body').removeClass 'login-screen'
  $field = @$ 'input[name="email"]'
  $field.off()


Template['invite-signup-complete'].events =
  'click #btn-complete-account-setup': (e)->
    e?.preventDefault()

    #: prevent double submit..
    return if invite_signup_complete.in_progress()
    invite_signup_complete.set_in_progress true

    #: serialize form fields
    name = $.trim @$('[name="name"]').val()
    #: always lowercase the email
    email = $.trim @$('[name="email"]').val().toLowerCase()
    #: use `accounts-passwords` package to encyrpt & set the password field
    password = $.trim @$('[name="password"]').val()

    # TODO: how to do meteor async 'waterfall' ?
    Accounts.changePassword null, password, (err)->
      if err?
        logger.error 'error completing account setup, unable to set password:', err.stack
        $('#invite-signup-complete').css opacity: 1
        invite_signup_complete.set_in_progress false

      else
        Meteor.call 'invite_signup_complete', name, email, password, (err, rv) ->
          if err?
            logger.error 'error completing account setup:', err.stack
            $('#invite-signup-complete').css opacity: 1
            invite_signup_complete.set_in_progress false
          else
            invite_signup_complete.on_signup_complete()


invite_signup_complete = new InviteSignupComplete
