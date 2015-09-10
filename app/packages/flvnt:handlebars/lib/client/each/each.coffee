
#
# because meteor-jade-handlebars sucks a fucking cunt-dick, i have to do this
# just to have access to a native handlebars helper.
#
UI.registerHelper 'each_with_index', (context, options) ->
  buffer = ""
  for ctx, i in context
    ctx.index = i
    buffer += options.fn ctx
  buffer

UI.registerHelper 'with_index', (all) ->
  i = 0
  _.each all, (item) =>
    item.index = i
    i = i + 1
  all
