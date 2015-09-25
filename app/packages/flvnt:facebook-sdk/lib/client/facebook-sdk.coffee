#: see: https://developers.facebook.com/docs/reference/javascript/

load_facebook_sdk = (api_key) ->
  doc = document
  debug = false
  return if doc.getElementById("fbroot")?

  window.fbAsyncInit = ->
    options =
      appId: api_key
      channelUrl: Meteor.absoluteUrl 'channel.html' # channel url for FB
      status: true # check the login status upon init?
      cookie: false # set sessions cookies to allow your server to access the session?
      xfbml: false # parse XFBML tags on this page?
    FB.init options

  (-> # load the SDK's source asynchronously
    return if not doc.body?.children?
    fbroot = doc.createElement "div"
    fbroot.id = "fbroot"
    doc.body.insertBefore fbroot, doc.body.children[0]

    id = "facebook-js-sdk"
    return if doc.getElementById(id)?

    scripts = doc.getElementsByTagName("script")[0]
    js = doc.createElement "script"
    js.id = id
    js.async = true
    js.src = "//connect.facebook.net/en_US/all" + (if debug then "/debug" else "") + ".js"
    scripts.parentNode.insertBefore js, scripts
  )()
