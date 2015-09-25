event-hooks
===========

provides hooks for user-account events


### API

currently, all API methods on the server take a `userId` argument:

 * `Hooks.onUserReady = function ([server: userId]) { ... }` ( _anywhere_ ) - Provide a callback to run when a user has logged in
 * `Hooks.onLoggedIn = function ([server: userId]) { ... }` ( _anywhere_ ) - Provide a callback to run when a user has logged in
 * `Hooks.onLoggedOut = function (userId) { ... }` ( _anywhere_ ) - Provide a callback to run when a user has logged out
 * `Hooks.onCreateUser = function (userId) { ... }` ( _server_ ) - Provide a callback to run when a user is created
 * `Hooks.onDeleteUser = function (userId) { ... }` ( _server_ ) - Provide a callback to run when a user is deleted
 * `Hooks.onLoseFocus = function ([server: userId]) { ... }` ( _anywhere_ )* - Provide a callback to run when the window loses focus. * Opt-in through the `updateFocus` option
 * `Hooks.onGainFocus = function ([server: userId]) { ... }` ( _anywhere_ )* - Provide a callback to run when the window gains focus * Opt-in through the `updateFocus` option
 * `Hooks.onCloseSession = function ([server: userId]) { ... }` ( _server_ ) - Provide a callback to run when the window/tab is closed


### SETUP

 * `Hooks.init [options]` ( _client_ ) - initialize the event system. optionally provide an `Object` to set the options. put this in `Meteor.startup`:

```
    Meteor.startup ->

      #: this NEEDS to fire AFTER the server-side alias_user call..
      Hooks.onUserReady = ->
        mixpanel.user_startup Meteor.userId()

      Hooks.init
        updateFocus: 50   # number of milliseconds to wait before checking whether the window is focused
        treatCloseAsLogout: true
```


### OPTIONS

Options are specified on the client side as an argument (object) in the `init` method.

 * `updateFocus` ( _Integer_ ) - Number of milliseconds to wait before checking whether the window is focused. Default is `0`, meaning unless you change this, the `onLoseFocus` and `onGainFocus` methods won't be available
 * `treatCloseAsLogout` ( _Boolean_ ) - If true, treat closing the browser window as logging off (meaning that the `onLoggedOut` callback is triggered in addition to the `onCloseSession`). Default is `false`


### USAGE

add `Hooks.init()` to `Meteor.startup` under a `client/` directory


```
    Meteor.startup ->
      Hooks.init()
```
