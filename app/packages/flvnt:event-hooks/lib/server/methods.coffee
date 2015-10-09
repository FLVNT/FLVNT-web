
Meteor.methods ->

  events_onLoseFocus: ()->
    # fire the loseFocus event
    Hooks.onLoseFocus @userId


  events_onGainFocus: ()->
    # fire the gainFocus event
    Hooks.onGainFocus @userId


  events_onCloseSession: ()->
    # fire the closeSession event
    Hooks.onCloseSession @userId


  events_onLoggedIn: ()->
    # fire the loggedIn event
    Hooks.onLoggedIn @userId


  events_onLoggedOut: (userId)->
    # fire the loggedOut event
    Hooks.onLoggedOut userId


  events_onUserReady: (userId)->
    # fire the loggedOut event
    Hooks.onLoggedOut userId
