
#: talent-user profile
Projects = new Mongo.Collection "projects", {}


Projects.attachSchema new SimpleSchema
  created_at : SchemaHelpers.created_at(optional: true)
  updated_at : SchemaHelpers.updated_at()
  deleted    : SchemaHelpers.soft_delete()

  brand_id:
    type: String
    label: "brand id"



Projects.helpers
  absolute_url: ->
    Meteor.absoluteUrl "brand/@brand_id/#{@_id}"

  brand: ->
    Brands.findOne '_id': @brand_id


Projects.visible_fields =
  'name'       : 1
  'images'     : 1
  'brand_id'   : 1


Projects.allow
  fetch: ['brand_id']

  insert: (userId, doc)->
    # TODO: or is_admin..
    (userId == doc.brand_id)

  update: (userId, doc, fields, modifier)->
    (userId == doc.brand_id)
