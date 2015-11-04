
FBFriends_2 = new Mongo.Collection null
FBFriends = new Mongo.Collection "facebook_friends"
FBFriendsByMusicLikes = new Mongo.Collection "facebook_friends_by_music_likes"

# schema = new SimpleSchema
#   # Force value to be current date (on server) upon insert
#   # and prevent updates thereafter.
#   created_at:
#     type: Date
#     autoValue: ->
#       if @isInsert
#         return new Date()
#       else if @isUpsert
#         return {$setOnInsert: new Date}
#       else
#         @unset()
#     label: "Created at"
#     # denyUpdate: true

#   'friends.$.name':
#     type: String
#     label: "Name"

#   'friends.$.id':
#     type: String
#     label: "Facebook id"

#   'friends.$.username':
#     type: String
#     label: "Username"
#     optional: true

#   # Force value to be current date (on server) upon update
#   # and don't allow it to be set upon insert.
#   updated_at:
#     type: Date
#     autoValue: ->
#       if @isUpdate
#         return new Date()
#     label: "Updated at"
#     denyInsert: true
#     optional: true

#   user_id:
#     type: String
#     label: "User"

# FBFriends.attachSchema schema

FBFriends.helpers {}
