
Meteor.publish "userData", ->
  @unblock()

  unless @userId?
    logger.warn '[APP-ACCOUNTS] @userId null in publish: userData, returning empty..'
    return @ready()

  query =
    '_id': @userId

  options =
    fields:
      'createdAt': 1
      'completed_setup': 1
      'profile.name': 1
      'notification_read_at': 1

      'stats.posts' : 1
      'stats.likes' : 1
      'stats.down'  : 1

      'groups.id'    : 1
      'groups.admin' : 1
      'groups.status': 1

      # facebook fields
      # ---------------
      'services.facebook.id': 1
      'services.facebook.username': 1
      # 'services.facebook.bio': 1
      # 'services.facebook.birthday': 1
      # 'services.facebook.email': 1
      # 'services.facebook.expiresAt': 1
      'services.facebook.gender': 1
      # 'services.facebook.link': 1
      # 'services.facebook.locale': 1
      # 'services.facebook.location': 1
      # 'services.facebook.music.data': 1

      # google fields
      # -------------
      # 'services.google.expiresAt': 1
      # 'services.google.id': 1
      # 'services.google.picture': 1

      # soundcloud fields
      # -----------------
      # 'services.soundcloud.avatar_url': 1
      # 'services.soundcloud.city': 1
      # 'services.soundcloud.country': 1
      # 'services.soundcloud.description': 1
      # 'services.soundcloud.followers_count': 1
      # 'services.soundcloud.followings_count': 1
      # 'services.soundcloud.id': 1
      # 'services.soundcloud.permalink_url': 1
      # 'services.soundcloud.playlist_count': 1
      # 'services.soundcloud.private_playlists_count': 1
      # 'services.soundcloud.private_tracks_count': 1
      # 'services.soundcloud.public_favorites_count': 1
      # 'services.soundcloud.track_count': 1
      # 'services.soundcloud.website': 1
      # 'library.soundcloud_favorite_ids': 1

  logger.info "[APP-ACCOUNTS] publish userData:", @userId
  pub = Meteor.users.find query, options
  return @ready() unless pub?
  pub
