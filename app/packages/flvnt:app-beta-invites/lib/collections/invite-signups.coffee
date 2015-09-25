
@InviteSignups = new Mongo.Collection "invite_signups", {}


InviteSignups.attachSchema new SimpleSchema
  created_at: SchemaHelpers.created_at()
  updated_at: SchemaHelpers.updated_at()

  email:
    type: String
    label: "Email"
    max: 256
    regEx: SimpleSchema.RegEx.Email

  invite_queue:
    type: String
    label: "Queue"
    allowedValues: InviteQueues

  name:
    type: String
    label: "Name"
    max: 128


InviteSignups.helpers {}


# TODO: remove this method and wherever its called
InviteSignups.create_signup = (options) ->
  doc = _.extend(_.pick(options, 'name', 'email', 'invite_queue'),
    created_at: new Date()
  )

  # TODO: allow duplicate emails for now. so bypass validation.

  InviteSignups.insert doc
