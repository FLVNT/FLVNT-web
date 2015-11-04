
FLVNT_FB = {}


# see: http://developers.facebook.com/docs/graph-api/reference/user/picture/
FLVNT_FB.graph_photo = (fbid, width, height)->
  return unless fbid?.length

  rv = "http://graph.facebook.com/#{fbid}/picture"

  if width? or height?
    rv += "?"

  if width?
    rv += "width=#{width}&"

  if height?
    rv += "height=#{height}&"
  rv
