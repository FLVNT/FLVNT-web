
AppSubscription =

  onError: (err)->
    logger.error 'error with subscription..', Router.current(), err
    if current_group()?
      infinite_scroll._rendr_count = 0
      infinite_scroll._paused      = false
      # TODO: check if exhausted() here?
      infinite_scroll.show_loader()

  onStop: ->
    # logger.warn '[group-subscribe:items-related-to-posts] onstop:', @
    if current_group()?
      infinite_scroll._rendr_count = 0
      infinite_scroll._paused      = false
      # TODO: check if exhausted() here?
      # infinite_scroll.show_loader()
