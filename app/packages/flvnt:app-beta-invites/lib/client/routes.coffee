
Router.map ->

  @route "invite/accept",
    controller: PageTrackerController
    path: "invite/accept/:_id?"
    template: 'invite-accept'
    data:
      show_header: false

    waitOn: ->
      invite_code_id = @params._id
      # check for an invitecode in session, if null, redirect to error.
      # otherwise redirect to invite code id route
      if not invite_code_id?.length
        return @redirect '/'

      # set the invite code id here, since the subscription is created
      # on change of this session var..
      Session.set 'invite_code_id', invite_code_id

      return [
        #@subscribe("userData"),
        @subscribe('InviteCode', invite_code_id),
        @subscribe("AcceptedInviteCode", Meteor.userId()),
      ]

    onBeforeAction: ->
      if not @ready()
        @render('route-loading')

      else
        invite_code_id = @params._id

        # check user is already logged in..
        user = Meteor.user()
        if user? and not _.isNull user
          # redirect to the user's groups list page
          if user.completed_setup
            logger.info "user logged in, and has completed their setup"
            return @redirect '/groups'

          else
            logger.info 'user logged in, but hasnt completed their account setup'
            # commented, moved to templates.invite-accept.coffee
            # return goto 'invite/signup/complete'
            return

        # check if code can be used to accept the invite..
        can_use_code = InviteCodes.can_accept_invite invite_code_id
        if not can_use_code
          # todo: handle error
          logger.warn "cannot use code, invalid invite code"
          # return @redirect '/'
        @next()


    # setup open-graph meta tags with the group data..
    onAfterAction: ->
      try
        invite_code_id = Session.get 'invite_code_id'
        group_invite = GroupInvites.findOne code: invite_code_id

        # TODO (rhone): can you help setup pub/sub for this?
        # - this is needed for facebook to scrape elegantly..
        # set_group_meta_tags Groups.findOne _id: group_invite.group_id
      catch err
        logger.error 'ERROR ACCEPTING INVITE:', err


  @route "invite/signup/complete",
    controller: PageTrackerController
    template: 'invite-signup-complete'
    data:
      show_header: false

    waitOn: ->
      [
        #@subscribe("userData"),
      ]

    onBeforeAction: ->
      if not @ready()
        @render('route-loading')

      else

        # check user is already logged in..
        user = Meteor.user()
        if user? and not _.isNull user
          # redirect to the user's groups list page
          if user.completed_setup is true
            logger.info "user logged in, and has already completed their setup.."
            # return @redirect '/groups'
          else
            logger.warn 'user has not completed their setup..'
            @next()
        else
          @next()
