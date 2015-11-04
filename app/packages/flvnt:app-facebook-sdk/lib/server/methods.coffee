
Meteor.methods

  get_facebook_friends: ->
    return null if not Meteor.userId()

    # logger.info 'get_facebook_friends:'
    FBFriends.findOne '_id': Meteor.userId()


  download_fbfriends: ->
    UserFacebook.download_fbfriends Meteor.user()


  disconnect_service: (service)->
    Accounts.disconnect_service service
