
# router setup + config
Router.configure {
  layoutTemplate   : "route-layout"
  loadingTemplate  : "route-loading"
  notFoundTemplate : "route-not-found"

  data: ->
    show_header : true

}
