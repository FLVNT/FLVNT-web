
FLVNTAccounts = FLVNTAccounts || {
  ui: {}
  # config is for managing service-configs
  config: {}
}


# NOTE: this is set here to provide server-side code access to the account-ui
# config object

config = {}
config.accounts = {}
config.accounts.service_providers = [
  'soundcloud',
  'google',
]
config.accounts.ui =

  passwordSignupFields: "USERNAME_AND_EMAIL"


  # THIRD-PARTY OAUTH CONFIG
  # ------------------------

  requestPermissions:
    facebook: [
      # USER-DATA BASIC
      # ----------------------------------------------
      # facebook permissions updated for: v2.3  2015-05-11
      # see: https://developers.facebook.com/docs/facebook-login/permissions/v2.3
      'public_profile', 'email',

      # USER-DATA EXPANDED
      # ----------------------------------------------
      'user_birthday', 'user_location', 'user_likes',

      # see: https://developers.facebook.com/docs/facebook-login/permissions#reference-user_actions_music
      'user_actions.music',

      # 'user_about_me',

      # deprecated 2015-07-23 - silently ignored
      # see: https://developers.facebook.com/docs/facebook-login/permissions#reference-user_interests
      # 'user_interests',

      # 'user_actions.videos', 'user_activities',
      # 'user_events', 'user_groups',  'user_interests',

      # WRITE PERMISSIONS (** USE CAUTION **)
      # ----------------------------------------------
      # 'publish_actions', 'publish_stream', 'status_update',
      # 'read_friendlists', 'read_requests', 'read_stream', 'share_item',

      # FRIEND DATA
      # ----------------------------------------------
      'user_friends',
      # 'friends_likes', 'friends_location',  # disabled 2015-05-11
      # 'friends_about_me',
      # 'friends_birthday',
      # 'friends_interests',
      # 'friends_actions.video', 'friends_actions.music', 'friends_activities',
      # 'friends_events', 'friends_groups', 'friends_interests',
    ]

    google: [
      # 'https://www.googleapis.com/auth/userinfo.profile',
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/youtube',
    ]

    soundcloud: [] # currently unsupported

  # only required by google for now
  requestOfflineToken:
    google: true
