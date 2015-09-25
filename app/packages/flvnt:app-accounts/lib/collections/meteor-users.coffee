# see: https://github.com/aldeed/meteor-collection2/blob/master/README.md#attaching-a-schema-to-a-collection

Meteor.users.attachSchema new SimpleSchema

  createdAt:
    type: Date
    label: "created at"
    optional: true

  updated_at: SchemaHelpers.updated_at()

  notifications_read_at:
    type: Date
    label: "notification read-at date"
    optional: true

  completed_setup:
    type: Boolean
    label: "completed setup"
    optional: true

  profile:
    # TODO: define as sub-schema for profile..
    type: Object
    label: "user profile"
    blackbox: true
    optional: true

  services:
    # TODO: define as sub-schema for services.
    type: Object
    label: "user accounts services"
    blackbox: true
    optional: true

  invite_code_id:
    type: String
    label: "invite-code-id"
    optional: true

  'groups.id':
    type: String
    label: "group id"
    optional: true

  'groups.status':
    type: String
    label: "group status"
    optional: true

  'groups.admin':
    type: Boolean
    label: "group admin"
    optional: true

  'emails.$.address':
      type: String
      label: "email address"
      optional: true

  'emails.$.verified':
      type: Boolean
      label: "verified"
      optional: true

  'stats.comments':
      type: Number
      label: "comments count"
      min: 0
      optional : true

  'stats.posts':
      type: Number
      label: "posts count"
      min: 0
      optional : true

  'stats.likes':
      type: Number
      label: "likes count"
      min: 0
      optional : true

  'stats.downvotes':
      type  : Number
      label : "downvotes count"
      min   : 0
      optional : true


Meteor.users.helpers
  parseEmail: ->
    if @emails

    else if @services
      email = switch
        when services.facebook then services.facebook.email
        when services.github   then services.github.email
        when services.google   then services.google.email
        when services.twitter  then null
        else null
      email
