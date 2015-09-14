
@GroupInvites = new Mongo.Collection "group_invite",

schema = new SimpleSchema
  code:
    type: String
    label: "Code"

  # Force value to be current date (on server) upon insert
  # and prevent updates thereafter.
  created_at:
    type: Date
    autoValue: ->
      if @isInsert
        return new Date()
      else if @isUpsert
        return {$setOnInsert: new Date}
      else
        @unset()
    label: "Created at"
    denyUpdate: true

  group_id:
    type: String
    label: "Group id"

  # Force value to be current date (on server) upon update
  # and don't allow it to be set upon insert.
  updated_at:
    type: Date
    autoValue: ->
      if @isUpdate
        return new Date()
    label: "Updated at"
    denyInsert: true
    optional: true

  user_id:
    type: String
    label: "Created by"

GroupInvites.attachSchema schema

GroupInvites.helpers {}


if Meteor.settings.public?.fb_popup_rhone? and Meteor.settings.public.fb_popup_rhone
  GroupInvites.allow
    insert: (userId, doc) ->
      return userId && doc.user_id == userId && Groups.findOne {_id: doc.group_id, 'members.id': userId}

  fetch: ['user_id']
