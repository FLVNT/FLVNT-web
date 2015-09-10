
# Returns: reference to the `<script>` tag inserted into the `<head>`
LazyLoad = (url, callback)->
  # create + insert the script tag
  tag = document.createElement "script"
  tag.type = "text/javascript"
  tag.src = url

  tag.onload = =>
    callback(null, tag) if callback?

  # callback when script doesn't load
  tag.onerror = (err)=>
    if err?.srcElement?
      logger.error '[LazyLoad]', ' script-load-error:',
        '\n- url:', url,
        '\n- error:  ', err,
        '\n- element:', err.srcElement,
        '\n- bubbles:', err.bubbles,

    else
      logger.error '[LazyLoad]', 'unknown-script-load-error:',
        '\n- url:', url,
        '\n- error:', err,

    callback(err) if callback?

  head = document.getElementsByTagName('head')[0]
  head.appendChild tag
  tag
