//////////////////////////////////
//= SETUP HOOKS OBJECT
//////////////////////////////////

Hooks = {

  //////////////////////////////////
  //= OPTIONS
  //////////////////////////////////

  options: {
    // number of milliseconds to poll between checking window focus
    updateFocusTimer: false,
    // treat window close as logout event
    treatCloseAsLogout: true,
  },

  //////////////////////////////////
  //= INTERNAL STATES
  //////////////////////////////////

  focused: true,
  loggedIn: false,
  lastUserId: null,

  userReady: false,
  lastUser: null,


  init: function (options) {
    //////////////////////////////////
    //= BASIC INITIALIZATION
    //////////////////////////////////

    // initialize options
    (options) && _.extend(this.options, options);

    //////////////////////////////////
    //= INITIALIZE CLIENT EVENTS
    //////////////////////////////////

    // Start checking for focus if a truthy integer is given
    if (this.options.updateFocusTimer !== false) {
      Meteor.setInterval(Hooks.checkFocus, this.options.updateFocusTimer);
    }

    // Close window/tab
    window.onbeforeunload = function() {
      Hooks.fire('onCloseSession');

      // if we're treating close as logout, fire the logout event as well
      if (Hooks.options.treatCloseAsLogout === true) {
        Hooks.fire('onLoggedOut');
      }
    };



    //////////////////////////////////
    //= SETUP LOGIN MONITORING
    //////////////////////////////////

    Tracker.autorun(function () {
      if (Meteor.userId()) {
        // User is logged in
        if (Hooks.loggedIn === false) {
          // Update the latest user id
          Hooks.lastUserId = Meteor.userId();
          // user wasn't logged in before this updated, so fire the loggedIn event
          Hooks.fire('onLoggedIn');
        }

        Hooks.loggedIn = true; // Now set the proper state
      } else {
        // there is no user logged in right now
        if (Hooks.loggedIn === true) {
          // user was logged in before this updated, so fire the loggedOut event
          Hooks.fire('onLoggedOut');
        }

        Hooks.loggedIn = false; // Now set the proper state
      }
    });

    Tracker.autorun(function () {
      user = Meteor.user();
      if (user) {
        // User is logged in
        if (Hooks.userReady === false) {
          // Update the latest user
          Hooks.lastUser = user;
          // user wasn't logged in before this updated, so fire the userReady event
          Hooks.fire('onUserReady', Hooks.lastUser._id);
        }

        Hooks.userReady = true; // Now set the proper state
      }
      else{
        Hooks.userReady = false;
      }
    });
  },


  //////////////////////////////////
  //= METHODS
  //////////////////////////////////
  fire: function (eventFn, userId) {
    if (! userId) {
      userId = Hooks.lastUserId;
    }

    // fire the event on the client
    _.isFunction(Hooks[eventFn]) && Hooks[eventFn](userId);

    // fire the event on the server
    Meteor.call('events_' + eventFn, userId);
  },

  checkFocus: function () {
    // check if the window is currently focused
    if (document.hasFocus() && Hooks.focused === false) {
      Hooks.gainFocus();

    } else if (! document.hasFocus() && Hooks.focused === true) {
      Hooks.loseFocus();
    }
  },

  gainFocus: function () {
    Hooks.focused = true;
    Hooks.fire('onGainFocus');
  },

  loseFocus: function () {
    Hooks.focused = false;
    Hooks.fire('onLoseFocus');
  },

  //////////////////////////////////
  //= DEFINE API METHODS
  //////////////////////////////////
  onLoseFocus:    function(){},
  onGainFocus:    function(){},
  onCloseSession: function(){},
  onLoggedIn:     function(){},
  onLoggedOut:    function(){},
  onUserReady:    function(){}
};
