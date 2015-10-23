
#: base controller to track new route visits as mixpanel page views.
PageTrackerController = RouteController.extend
  loadingTemplate: 'route-loading'

  waitOn: ->
    [
      subs.subscribe("userData"),
    ]

  onRun: ->
    return @render('route-loading') unless @ready()

    Mp?.track_pageview @path
    @next()
