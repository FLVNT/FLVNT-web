
# router setup + config
Router.configure {
  layoutTemplate   : "global_layout"
  loadingTemplate  : "route-loading"
  notFoundTemplate : "not-found"

  data: ->
    show_header : true

}
