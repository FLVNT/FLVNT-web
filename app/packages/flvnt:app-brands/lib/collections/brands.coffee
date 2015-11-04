
#: brand profile
Brands = new Mongo.Collection "brands", {}


Brands.attachSchema new SimpleSchema
  created_at : SchemaHelpers.created_at optional: true
  updated_at : SchemaHelpers.updated_at()
  deleted    : SchemaHelpers.soft_delete()

  name:
    type  : String
    label : "name"
    max   : 128

  owner_id:
    type  : String
    label : "created by / owner user"

  member_ids:
    type  : [String]
    label : "member ids"

  "members.$.id":
    type  : String
    label : "user id"

  "members.$.admin":
    type  : Boolean
    label : "is admin"

  "images.$.url":
    type  : String
    label : "image url src"

  "images.$.type":
    type  : String
    label : "image display type"
    allowedValues: ['cover', 'thumb']


Brands.helpers
  absolute_url: ->
    Meteor.absoluteUrl "brand/#{@_id}"

  owner: ->
    Meteor.users.findOne '_id': @owner_id

  is_owner: (user_id)->
    user_id == @owner_id

  is_member: (user_id)->
    user_id in @member_ids

  is_admin: (user_id)->
    user_id in @admin_ids() or user_id == @owner_id

  admin_ids: ->
    admins = _.filter @members, (member)->
      member.admin == true
    _.pluck admins, 'id'

  admin_count: ->
    @admin_ids().length

  member_users: ->
    Meteor.users.find '_id': {$in: @member_ids}

  member_count: ->
    @member_ids.length


Brands.visible_fields =
  'name'       : 1
  'images'     : 1
  'owner_id'   : 1
  'members'    : 1
  'member_ids' : 1
  # TODO: do we need this .. ?
  # 'created_at' : 1


Brands.allow
  fetch: ['owner_id', 'members']

  insert: (userId, doc)->
    (userId == doc.owner_id or Brands.is_admin(userId, doc))

  update: (userId, doc, fields, modifier)->
    (userId == doc.owner_id or Brands.is_admin(userId, doc))


Brands.is_admin = (user_id, doc)->
  _admins = _.filter doc.members, (member)->
    member.admin == true
  admin_ids = _.pluck _admins, 'id'
  _.contains admin_ids, user_id
