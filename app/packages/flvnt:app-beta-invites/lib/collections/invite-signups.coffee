
InviteSignups = new Mongo.Collection "invite_signups", {}


InviteSignups.attachSchema new SimpleSchema
  created_at: SchemaHelpers.created_at()
  updated_at: SchemaHelpers.updated_at()

  email:
    type  : String
    label : "email"
    max   : 256
    regEx: SimpleSchema.RegEx.Email

  invite_queue:
    type     : String
    label    : "invite queue"
    optional : true
    allowedValues: InviteQueues

  name:
    type  : String
    label : "name"
    max   : 128


InviteSignups.helpers {}
