
class _LazyLoad
  constructor: (url, callback)->
    @_tracker = new Tracker.Dependency
    @_loaded = false

  setLoaded: (value)->
    return if @_loaded == value
    @_loaded = value
    @_tracker.changed()


#: returns: reference to the `<script>` tag inserted into the `<head>`
LazyLoad = (url, callback)->
  unless Meteor.Online.isOnline()
    return logger.warn '[LAZYLOAD]', 'client connection not online..'

  #: create + insert the script tag
  tag = document.createElement "script"
  tag.type = "text/javascript"
  tag.src = url

  tag.onload = =>
    callback(null, tag) if callback?

  #: callback when script doesn't load
  tag.onerror = (err)=>
    if err?.srcElement?
      logger.error '[LazyLoad]', ' script-load-error:',
        '\n- url:  ', url,
        '\n- error:', err,
        '\n- error.type:', err.type,
        '\n- error.target:', err.target,
        '\n- error.bubbles:', err.bubbles,
        '\n- error.timeStamp:', err.timeStamp,
        '\n- error.cancelable:', err.cancelable,
        '\n- error.eventPhase:', err.eventPhase,
        '\n- error.returnValue:', err.returnValue,
        '\n- error.defaultPrevented:', err.defaultPrevented,
        '\n- element:', err.srcElement,

    else if err?
      logger.error '[LazyLoad]', 'unknown-script-load-error:',
        '\n- url:', url,
        '\n- error:', err,

    callback(err) if callback?

  head = document.getElementsByTagName('head')[0]
  head.appendChild tag
  tag
