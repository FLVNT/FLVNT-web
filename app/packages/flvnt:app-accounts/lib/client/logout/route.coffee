
Router.map ->

  @route "/logout",
    # controller: PageTrackerController
    name: "logout"

    # waitOn: ->
    #   [
    #     @subscribe("userData"),
    #   ]

    onBeforeAction: ->
      Meteor.logout ->
        logger.info "[ACCOUNTS] user is logged out.."

        #: clear cache from subs-manager (see: https://github.com/kadirahq/subs-manager/issues/15)
        subs.clear()
        group_subs.clear()
        notifications_subs.clear()
        notifications_count_sub.clear()
      @redirect 'index'


Router.logout = ->
  logger.info '[ACCOUNTS] logging the user out..'
  Router.goto 'logout'

