
#
# converts a unix timestamp to a nice and pretty string.
#
UI.registerHelper 'U2Gtime', (unixtime) ->
  return '' unless unixtime?
  d = new Date()
  d.setTime unixtime
  d.toDateString()
