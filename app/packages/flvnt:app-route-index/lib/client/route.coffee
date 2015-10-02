
Router.map ->

  @route "/",
    # controller: PageTrackerController
    template: 'index'

    data: ->
      show_header: false

    waitOn: ->
      [
        subs.subscribe("userData"),
        # subs.subscribe('AcceptInviteCode', invite_code_id),
        # subs.subscribe("UserAcceptedInviteCode"),
      ]

    onBeforeAction: ->
      unless @ready()
        return @render 'route-loading'

      #: check user is already logged in..
      user = Meteor.user()
      if user? and not _.isNull user
        #: redirect to the user's groups list page
        if user.completed_setup is true
          logger.info "user logged in, and has already completed their setup.."
          #: return @redirect '/groups'

        else
          logger.warn 'user has not completed their setup..'
          @next()

      else
        @next()
