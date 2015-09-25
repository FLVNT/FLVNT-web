
TRACE = true


Meteor.startup =>
  configure_tracing()
  configure_for_mobile()
  configure_third_party_sdks()


configure_tracing = =>
  return unless TRACE

  # log sent messages
  _send = Meteor.connection._send

  Meteor.connection._send = (obj) ->
    logger.info 'send:', obj
    _send.call this, obj
    return

  # log received messages
  Meteor.connection._stream.on 'message', (message) ->
    logger.info 'receive:', JSON.parse(message)
    return

  if window.applicationCache.status is 0
    logger.info 'page loaded from network..'
  else
    logger.info 'page loaded from AppCache..'


configure_for_mobile = =>

  # set browser-detection
  agent = navigator.userAgent.toLowerCase()
  @is_desktop          = ((agent.indexOf('windows') > -1) || (agent.indexOf('macintosh') > -1) || (agent.indexOf('linux') > -1)) && agent.indexOf('mobile') < 0 && agent.indexOf('nexus') < 0
  @is_chrome_desktop   = (agent.indexOf('chrome') > -1 && is_desktop)
  @is_touch_capable    = ('ontouchstart' in window && !is_chrome_desktop)
  @orientation_support = ('orientation' in window && 'onorientationchange' in window)

  @startevent  = ('ontouchstart' in window && !is_chrome_desktop) ? 'touchstart' : 'mousedown'
  @endevent    = ('ontouchstart' in window && !is_chrome_desktop) ? 'touchend'   : 'mouseup'
  @moveevent   = ('ontouchstart' in window && !is_chrome_desktop) ? 'touchmove'  : 'mousemove'
  @tapevent    = ('ontouchstart' in window && !is_chrome_desktop) ? 'tap'        : 'click'
  @scrollevent = ('ontouchstart' in window && !is_chrome_desktop) ? 'touchmove'  : 'scroll'


  FastClick.attach document.body


configure_third_party_sdks = =>

  # load accounts-related third-party sdks
  load_facebook_sdk  Meteor.settings.public.facebook_client_id
  load_google_sdk    Meteor.settings.public.google_client_id

  # see: https://developers.inkfilepicker.com/docs/web/v1/
  load_filepicker_sdk  Meteor.settings.public.filepicker.key, 'v1'
