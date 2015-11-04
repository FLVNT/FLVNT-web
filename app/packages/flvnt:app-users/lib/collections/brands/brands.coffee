
Brands = new Mongo.Collection "brands", {}


Brands.attachSchema new SimpleSchema
  created_at : SchemaHelpers.created_at(optional: true)
  updated_at : SchemaHelpers.updated_at()
  deleted    : SchemaHelpers.soft_delete()

  services:
    # TODO: define as sub-schema for services.
    type: Object
    label: "user accounts services"
    blackbox: true
    optional: true

  profile:
    # TODO: define as sub-schema for profile..
    type: Object
    label: "user profile"
    blackbox: true
    optional: true

  'emails.$.address':
      type: String
      label: "email address"
      optional: true

  'emails.$.verified':
      type: Boolean
      label: "verified"
      optional: true


  completed_setup:
    type: Boolean
    label: "completed setup"
    optional: true

  #: _id to the referer / inviter..
  invite_code_id:
    type: String
    label: "invite-code-id"
    optional: true

  notifications_read_at:
    type: Date
    label: "notification read-at date"
    optional: true

  'stats.comments':
      type: Number
      label: "comments count"
      min: 0

  'stats.posts':
      type: Number
      label: "posts count"
      min: 0

  'stats.likes':
      type: Number
      label: "likes count"
      min: 0

  'stats.down':
      type: Number
      label: "downvotes count"
      min: 0
      optional : true
