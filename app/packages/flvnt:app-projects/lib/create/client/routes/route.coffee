
Router.map ->

  @route "/brands/projects/create",
    controller: PageTrackerController
    template: 'projects_create'

    data: ->
      # TODO: query data from the subs within `waitOn()`
      show_header: false

    waitOn: ->
      [
        # subs.subscribe('AcceptInviteCode', invite_code_id),
      ]

    onBeforeAction: ->
      # TODO: figure out
