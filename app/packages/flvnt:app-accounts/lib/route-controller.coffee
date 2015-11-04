
#: base controller to track new route visits as mixpanel page views.
PageTrackerController = RouteController.extend

  # loadingTemplate: 'route-loading'

  waitOn: ->
    [
      subs.subscribe("userData"),
      # subs.subscribe("userData"1, AppSubsription),
    ]

  onRun: ->
    return @render('route-loading') unless @ready()

    Mp?.track_pageview @path
    @next()

  onStop: ->
    logger.info '[PageTrackerController]:STOP'
