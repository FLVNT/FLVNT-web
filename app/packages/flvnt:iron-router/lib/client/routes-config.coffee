
# router setup + config
Router.configure {
  layoutTemplate: "global_layout"
  loadingTemplate: "route-loading"
  notFoundTemplate: "not-found"
  data:
    show_header: true
}


goto = (path) ->
  Router.go Router.path(path)
  return
