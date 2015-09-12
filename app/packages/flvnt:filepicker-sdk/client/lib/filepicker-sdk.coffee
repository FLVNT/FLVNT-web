
# load the filepicker js sdk dynamically
load_filepicker_sdk = (api_key, api_version, callback) ->
  # api_key arg is required
  if not api_key? or api_key == ""
    throw new Meteor.Error 'please pass a valid api key'

  # make api_version + callback args optional
  if not api_version?
    api_version = "v1"

  else if not callback? and api_version? and _.isFunction api_version
    callback = api_version
    api_version = "v1"

  # create + insert the script tag
  script = document.createElement 'script'
  script.type = 'text/javascript'
  script.src = "//api.filepicker.io/#{api_version}/filepicker.js"

  script.onload =  ->
    filepicker.setKey api_key
    callback(null, filepicker) if callback?

  # callback when script doesn't load
  script.onerror = (err) ->
    console.error(err) if console?
    callback(err, null) if callback?

  # load the script tag
  head = document.getElementsByTagName('head')[0]
  head.appendChild script
