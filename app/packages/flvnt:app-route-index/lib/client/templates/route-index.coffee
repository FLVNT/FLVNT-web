
Template.index.onRendered = ->


Template.index.helpers


Template.index.events
  'mouseover .tile-card': (e, template)->
    $e = $ e.currentTarget
    $e.addClass('fadeout')
    template.data.revert = false

  'mouseout .tile-card': (e, template)->
    $e = $ e.currentTarget
    $e.removeClass('fadeout')
    template.data.revert = true

  'click .btn.brands-agencies': (e, template)->
    e.preventDefault()
    return if _connect_lock
    _connect_lock = true

  'click .btn.artists-influencers': (e, template)->
    e.preventDefault()
    return if _connect_lock
    _connect_lock = true

    logger.info 'connecting to instagram...'

    Meteor.loginWithInstagram (err, res)->
      if err?
        logger.error 'INSTAGRAM-OAUTH-ERROR:', err
      else
      logger.error 'INSTAGRAM-OAUTH-SUCCESS:', res

  'click .tile-card': (e, template)->
    $e = $ e.currentTarget
    $e.removeClass('fadeout').addClass('fadein')

    revert = ->
      Meteor.setTimeout (->
        if not template.data.revert
          template.data.revert = true
          return revert()
        else
          $e.removeClass('fadeout').removeClass('fadein')
      ), 500
    revert()


_connect_lock = false
