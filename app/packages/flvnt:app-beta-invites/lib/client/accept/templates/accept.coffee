
Template['invite-accept'].helpers
  vimeo_url: ->
    videoid = "110487652"
    "//player.vimeo.com/video/#{videoid}?title=0&amp;byline=0&amp;portrait=0&amp;autoplay=1&amp;loop=1"

  has_invited_by: ->
    invite = InviteCodes.findOne _id: Router.current().params._id
    return invite?

  invited_by: ->
    invite = InviteCodes.findOne _id: Router.current().params._id
    return if not invite?

    if invite.invite_signup_id?.length
      # invitecode created by unvael admins
      "we're happy to provide "
    else
      # invitecode created by groupinvite
      created_by = invite.created_by_name()
      if created_by?.length
        "#{created_by} is providing "
      else
        "we're happy to provide "


Template['invite-accept'].rendered = ->
  $('html, body').addClass 'login-screen'
  @$('.btn[data-event=facebook-connect]').popover 'toggle'
  Mp.track_view_accept_invite 'invite-code-id': Router.current().params._id


Template['invite-accept'].destroyed = ->
  $('html, body').removeClass 'login-screen'
  @$('.btn[data-event=facebook-connect]').off()


Template['invite-accept'].events
  'click [data-event="submit"]': (e, template) ->
    e?.preventDefault()

  'click [data-event="facebook-connect"]': (e) ->
    e?.preventDefault()
    dim()

    invite_code_id = Router.current().params._id

    # log to mixpanel
    Mp.track_accept_invite_facebook_click 'invite-code-id': invite_code_id

    callback = (err, rv)->
      enlighten()

      if not err?
        # mark invite code as used
        if invite_code_id?.length
          logger.info "marking invitecode as accepted:", invite_code_id
          Meteor.call 'accept_invite_code', invite_code_id, (e, rv) ->
            if e?
              logger.error 'error accepting invite code:', e.stack
            else
              goto 'invite/signup/complete'
        else
          goto 'invite/signup/complete'

      else if err is Accounts.LoginCancelledError
        logger.warn 'logincancellederror connecting with facebook', err

      else
        logger.error 'error connecting with facebook:', err

    Accounts.ui.connectWithFacebook callback


dim = ->
  $container = $ '.header-23-sub'
  $container.addClass 'loading'

enlighten = ->
  $container.removeClass 'loading'
