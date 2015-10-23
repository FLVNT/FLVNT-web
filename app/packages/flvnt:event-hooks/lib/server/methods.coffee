
Meteor.methods ->

  #: fire the loseFocus event
  events_onLoseFocus: ()->
    Hooks.onLoseFocus @userId

  #: fire the gainFocus event
  events_onGainFocus: ()->
    Hooks.onGainFocus @userId

  #: fire the closeSession event
  events_onCloseSession: ()->
    Hooks.onCloseSession @userId

  #: fire the loggedIn event
  events_onLoggedIn: ()->
    Hooks.onLoggedIn @userId

  #: fire the loggedOut event
  events_onLoggedOut: (userId)->
    Hooks.onLoggedOut userId

  #: fire the loggedOut event
  events_onUserReady: (userId)->
    Hooks.onLoggedOut userId
