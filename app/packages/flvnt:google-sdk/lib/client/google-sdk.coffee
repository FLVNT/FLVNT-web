
load_google_sdk = (api_key, callback) ->

  window.google_sdk_loaded = ->
    gapi.client.setApiKey api_key

  LazyLoad "https://apis.google.com/js/client.js?onload=load", (err, rv) ->
    if err?
      # logger.error 'error loading google-sdk script:', err
      callback(err) if callback?
    else
      callback() if callback?
