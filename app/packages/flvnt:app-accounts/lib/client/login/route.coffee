
Router.map ->
  @route "/login",
    controller: PageTrackerController
    name: "login"
    template: 'app-login'

    data: ->
      show_header: false

    # waitOn: ->
    #   [
    #     @subscribe("userData"),
    #   ]

    onBeforeAction: ->
      #: check user is already logged in..
      user = Meteor.user()
      return @next() unless user?

      #: redirect to the user's groups list page
      if user.completed_setup
        logger.info "[ACCOUNTS] user logged in, and has completed their setup"
        @redirect 'groups/explore/100'

      else
        logger.warn '[ACCOUNTS] user logged in, but hasnt completed their account setup'
        # TODO: broken.. need to re-implement this screen..
        # @redirect '/invite/signup/complete'
        @redirect 'groups/explore/100'
