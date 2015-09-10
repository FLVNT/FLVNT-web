
UI.registerHelper "facebook_graph_photo", (fbid, width, height) ->
  unvaelfb.graph_photo fbid, width, height


UI.registerHelper "background_img", (url) ->
  if url?.length
    "background-image: url('#{url}');"
  else
    # logger.warn 'not a valid url!'
    ""
