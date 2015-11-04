
#: talent-user profile
Talent = new Mongo.Collection "talent", {}


Talent.attachSchema new SimpleSchema
  created_at : SchemaHelpers.created_at(optional: true)
  updated_at : SchemaHelpers.updated_at()
  deleted    : SchemaHelpers.soft_delete()

  user_id:
    type: String
    label: "user id"


Talent.helpers
  absolute_url: ->
    Meteor.absoluteUrl "talent/#{@_id}"

  user: ->
    Meteor.users.findOne '_id': @user_id


Talent.visible_fields =
  'name'       : 1
  'images'     : 1
  'user_id'    : 1
  # TODO: do we need this .. ?
  # 'created_at'   : 1


Talent.allow
  fetch: ['user_id']

  insert: (userId, doc)->
    # TODO: or is_admin..
    (userId == doc.user_id)

  update: (userId, doc, fields, modifier)->
    (userId == doc.user_id)
