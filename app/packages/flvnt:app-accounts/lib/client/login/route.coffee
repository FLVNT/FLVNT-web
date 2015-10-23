
Router.map ->
  @route "/login",
    controller: PageTrackerController
    name: "login"
    template: 'app-login'

    data: ->
      show_header: false

    waitOn: ->
      [
        # @subscribe("userData"),
      ]

    onBeforeAction: ->
      unless @ready()
        return @render 'route-loading'

      #: check user is already logged in..
      user = Meteor.user()
      if user?
        #: redirect to the user's groups list page
        if user.completed_setup
          logger.info "[ACCOUNTS] user logged in, and has completed their setup"
          return @redirect 'groups'

        else
          logger.warn '[ACCOUNTS] user logged in, but hasnt completed their account setup'
          # return @redirect '/invite/signup/complete'
          return @redirect 'groups'
      else
        @next()
