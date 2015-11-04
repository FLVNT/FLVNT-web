
FLVNT_FB.config ?= {}

FLVNT_FB.config.endpoint = 'https://graph.facebook.com'


#: see: http://developers.facebook.com/docs/reference/login/public-profile-and-friend-list/
FLVNT_FB.config.IDENTITY_FIELDS = [
  'id', 'name', 'email', 'first_name', 'last_name', 'gender',
  'link', 'age_range', 'birthday', 'bio',
  'devices', 'location', 'interested_in', 'music',
  'picture.type(large)',
]

FLVNT_FB.config.FRIEND_FIELDS = ['id', 'name']


#: returns user data from the facebook graph api: `/me` call
FLVNT_FB.getIdentity = (user, fields) ->
  if _.isString user
    access_token = user
  else
    access_token = user.services.facebook.accessToken

  unless access_token?.length
    return logger.error 'user access_token null..', user

  unless fields?
    fields = FLVNT_FB.config.IDENTITY_FIELDS.join ","

  rv = Meteor.http.get "#{FLVNT_FB.config.endpoint}/me",
    params:
      access_token: access_token
      fields: fields

  #: TODO: use Meteor.retry for http connection errors ..?
  if rv.error?

    stack = rv.error
    if rv.error?.stack?
      stack = rv.error.stack

    res = {}
    if rv.error?.response?
      res = rv.error.response

    throw _.extend(
      new Meteor.Error("failed to fetch identity from facebook: #{stack}"),
      {response: res})
  rv.data


#Meteor.methods
#  test_get_friends: () ->
#    user = Meteor.user()
#    FLVNT_FB.getFriends user



#: get facebook friend data from facebook
FLVNT_FB.getFriends = (user)->
  options =
    params:
      access_token: user.services.facebook.accessToken
      fields: FLVNT_FB.config.FRIEND_FIELDS.join ","

  try
    rv = Meteor.http.get "#{FLVNT_FB.config.endpoint}/me/friends", options

    if rv.error?
      #: 400-error:  oauth-exception / token expiration..
      #: - type: OAuthException
      #: - code: 190
      #: - sub-code: 463
      stack = rv.error
      if rv.error?.stack?
        stack = rv.error.stack

      res = {}
      if rv.error?.response?
        res = rv.error.response

      throw _.extend(
        new Meteor.Error("error downloading facebook friends: #{stack}"),
        {
          response: res
        })
    rv.data
  catch err
    logger.error '[FLVNT-FB] http error getting friends:', {
      user_fbid: user._id
      user_name: user.profile.name
      user_email: user.emails[0]?.address
      err_stack: err.stack
      err_type : err.type
      err_message : err.message
      err_code : err.code
      err_fbtrace_id : err.fbtrace_id
    }
    throw e   # bubble the exception..


querystring = Npm.require 'querystring'


#: returns an object containing:
#: - accessToken
#: - expiresIn: lifetime of token in seconds
FLVNT_FB.getTokenResponse = (query) ->
  config = ServiceConfiguration.configurations.findOne service: 'facebook'
  unless config?
    throw new ServiceConfiguration.ConfigError "account service not configured in db!"

  try
    #: request an access token
    unless config.redirect_uri?
      redirect_uri = Meteor.absoluteUrl "_oauth/facebook?close"
    else
      redirect_uri = config.redirect_uri

    #: reserved query args already set by meteor oauth.
    reserved = ['close', 'code', 'state']

    #: set querystring args pased in through query object.
    for own key, val of query
      # console.info 'query:', 'key=', key, 'value=', val
      continue if _.indexOf(reserved, key) > -1 or not val?.length
      redirect_uri += "&#{key}=#{val}"

    # console.info 'redirect_uri:', redirect_uri

    res = HTTP.get(
      "#{FLVNT_FB.config.endpoint}/oauth/access_token",
        params:
          client_id: config.appId
          redirect_uri: redirect_uri
          client_secret: config.secret
          code: query.code
      ).content

    console.info 'facebook response:', res
  catch err
    throw _.extend(
      new Meteor.Error(
        "failed to complete oauth handshake with facebook: #{err.stack}"),
        {response: err.response})

  #: if 'res' parses as JSON, it is an error.
  #: XXX which facebook error causes this behvaior?
  if isJSON res
    console.error 'facebook oauth error response json:', res
    throw new Meteor.Error(
      "failed to complete oauth handshake with " +
      "facebook: #{res}")

  #: success,  extracts the facebook access token and expiration
  #: time from the response
  parsed_res = querystring.parse res
  access_token = parsed_res.access_token
  access_token_expires = parsed_res.expires

  unless access_token?.length
    throw new Meteor.Error(
      "failed to complete oauth handshake with facebook " +
      "-- can't find access token in http response. #{res}")

  return {
    accessToken: access_token
    expiresIn: access_token_expires
  }


#: checks whether a string parses as JSON
isJSON = (str) ->
  try
    JSON.parse str
    return true
  catch e
    return false
