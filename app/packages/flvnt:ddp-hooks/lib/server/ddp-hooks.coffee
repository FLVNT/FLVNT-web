#: see: https://raw.githubusercontent.com/mad-eye/ddpHooks/master/ddpHooks.coffee

###
# DDP.onConnect takes a callback that is called when a DDP session is
# established.  It is passed the sessionId.
#
# TODO: Accept context
#
# DDP.onConnect can be called anywhere on the server.
# @params callback: (sessionId) ->
###
DDP.onConnect = (callback) ->
  unless _.isFunction callback
    throw new Meteor.Error "[DDP-hooks] Meteor.onConnect must be passed a function"
  connectCallbacks.push callback


###
# DDP.onDisconnect takes a sessionId (or session object or subscription object)
# it is called when that session disconnects, and it is passed a sessionId
# of the disconnecting session.
#
# XXX: this does not currently fire on server restarts (eg, hot-code-reloads).
#
# @param handle: either sessionId, session, or subscription.
# @param callback: (sessionId) ->
###
DDP.onDisconnect = (handle, callback) ->
  if _.isString handle
    sessionId = handle

  #: presumably an object
  else if handle._session?
    #: this is a subscription
    sessionId = handle._session.id

  else if handle.server and handle.socket
    #: this is a session
    sessionId = handle.id

  unless sessionId
    throw new Meteor.Error "[DDP-hooks] sessionId argument required for disconnect callback"

  unless _.isFunction callback
    throw new Meteor.Error "[DDP-hooks] DDP.onDisconnect must be passed a sessionId and a function"

  disconnectCallbacks[sessionId] ?= []
  disconnectCallbacks[sessionId].push callback


#: internal: store callbacks
connectCallbacks = []
_invokeConnectCallbacks = (sessionId) ->
  callback(sessionId) for callback in connectCallbacks

disconnectCallbacks = {}
_invokeDisconnectCallbacks = (sessionId) ->
  callbacks = disconnectCallbacks[sessionId]
  return unless callbacks?.length

  callback(sessionId) for callback in callbacks
  delete disconnectCallbacks[sessionId]


#: internal: poll and notice when sessions connect/disconnect.
existing_session_ids = []

INTERVAL = Meteor.settings.sessionInterval || 1000

Meteor.setInterval (->
  current_session_ids = _.keys Meteor.server.sessions

  #: new open sessions

  new_session_ids = _.difference current_session_ids, existing_session_ids

  if new_session_ids.length
    logger.info("[DDP-hooks] new-session-ids:", new_session_ids)
    for sessionId in new_session_ids
      _invokeConnectCallbacks sessionId

  #: closed sessions

  closed_session_ids = _.difference existing_session_ids, current_session_ids

  if closed_session_ids.length
    logger.info "[DDP-hooks] closed-session-ids:", closed_session_ids
    for sessionId in closed_session_ids
      _invokeDisconnectCallbacks sessionId

  existing_session_ids = current_session_ids

), INTERVAL
