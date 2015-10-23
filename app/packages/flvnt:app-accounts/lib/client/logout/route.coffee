
Router.map ->

  @route "/logout",
    # controller: PageTrackerController
    name: "logout"

    waitOn: ->
      [
        # @subscribe("userData"),
      ]

    onBeforeAction: ->
      unless @ready()
        return @render 'route-loading'

      Meteor.logout ->
        logger.info "[ACCOUNTS] user is logged out.."
      @redirect 'index'


Router.logout = ->
  logger.info '[ACCOUNTS] logging the user out..'
  Router.goto 'logout'

