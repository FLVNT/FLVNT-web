
#: creates instances of meteorhacks:subsmanager
#: see: github.com/kadirahq/subs-manager
#: see: kadira.io/academy/meteor-routing-guide/content/subscriptions-and-data-management/using-subs-manager

#: 2015-10-23 / gregory
#: replaced with SubsCache (github.com/ccorcos/meteor-subs-cache)
#: atmospherejs.com/ccorcos/subs-cache
#: reason: clearing the sub-cache with a timeout seemed like a better UX..

subs = new SubsCache

talent_subs = new SubsCache {
  cacheLimit: 999
  #: time (in minutes) to expire cache in..
  #: since we're a music platform, let's make it a solid 2 hours, and hope we
  #: get users to bust through that time-on-site..
  expireIn: 120
  expireAfter: 120
}

notifications_subs = new SubsCache
notification_count_sub = new SubsCache
