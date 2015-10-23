
Router.map ->

  @route "invite/accept",
    controller: PageTrackerController
    path: "invite/accept/:_id?"
    template: 'invite-accept'

    data: ->
      invite_code_id = Session.get('accept_invite_code_id')

      invite_code_id: invite_code_id
      invite: GroupInvites.findOne 'code': invite_code_id
      show_header: false

    waitOn: ->
      invite_code_id = @params._id
      #: check for an invitecode in session, if null, redirect to error.
      #: otherwise redirect to invite code id route
      # TODO: set session variable for error..?
      unless invite_code_id?.length
        return @redirect '/invite/error'

      #: set the invite code id here, since the subscription is created
      #: on change of this session var..
      Session.set 'accept_invite_code_id', invite_code_id

      [
        subs.subscribe("userData"),
        subs.subscribe('AcceptInviteCode', invite_code_id),
        subs.subscribe("UserAcceptedInviteCode"),
      ]

    onBeforeAction: ->
      unless @ready()
        return @render 'route-loading'

      invite_code_id = @params._id

      #: check user is already logged in..
      user = Meteor.user()
      if user? and not _.isNull user
        #: redirect to the user's groups list page
        if user.completed_setup
          logger.info "user logged in, and has completed their setup"
          return @redirect '/groups'

        #: commented, moved to templates.invite-accept.coffee
        # else
        #   logger.info 'user logged in, but has not completed account setup..'
        #   return @redirect 'invite/signup/complete'

      #: check if code can be used to accept the invite..
      can_accept = InviteCodes.can_accept_invite invite_code_id
      unless can_accept
        # TODO: set session variable for error..?
        logger.warn "cannot accept invite, invalid invite code:", invite_code_id
        return @redirect '/invite/error'

      @next()


    #: setup open-graph meta tags with the group data..
    onAfterAction: ->
      try
        # TODO (rhone): can you help setup pub/sub for this?
        # - this is needed for facebook to scrape elegantly..
        # set_group_meta_tags Groups.findOne _id: group_invite.group_id
      catch err
        logger.error 'error accepting invite:', err
