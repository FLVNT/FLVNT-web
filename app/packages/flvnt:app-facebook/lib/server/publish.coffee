
if Features.ENABLE_FBFRIENDSBYMUSICLIKES

  Meteor.publish "FBFriends", ->
    if not @userId?
      return @ready()

    logger.info "publish facebook friends: #{@userId}"
    pub = FBFriends.find _id: @userId
    return @ready() if not pub?
    pub


  Meteor.publish "FBFriendsByMusicLikes", ->
    @unblock()

    if not @userId?
      return @ready()

    logger.info "publish fb friends agg by music likes: #{@userId}"
    pub = FBFriendsByMusicLikes.find(
      { user_id: @userId },
      { limit: 100, sort: { likes: -1 }}
    )
    return @ready() if not pub?
    pub

