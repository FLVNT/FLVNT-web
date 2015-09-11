
# feature-flags to enable/disable certain code-blocks in the app

Features =

  ENABLE_SHEPHERD              : false
  ENABLE_LOCKER                : false
  ENABLE_MSSEO                 : false
  ENABLE_SOUNDCLOUD_LIBRARY    : false
  ENABLE_FBFRIENDSBYMUSICLIKES : false
  ENABLE_INVITECODES           : false
  ENABLE_USERPROFILES          : false
  CACHE_API_SEARCH_RESULTS     : false

  CRON:
    ENABLED            : true

  NOTIFICATION_DIGEST:
    ENABLED            : true
    ENABLE_ADMINS_ONLY : true

  GROUPS:
    CONFIRM_NEW_PLAYLIST     : false
    REMOVE_SUB_ON_ROUTE_STOP : false

  TRACK_SEARCH:
    CLEAR_SEARCH_ON_CLOSE : true
