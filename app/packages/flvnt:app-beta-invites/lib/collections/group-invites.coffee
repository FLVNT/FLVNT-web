
GroupInvites = new Mongo.Collection "group_invite"


GroupInvites.attachSchema new SimpleSchema
  created_at: SchemaHelpers.created_at()
  updated_at: SchemaHelpers.updated_at()

  code:
    type: String
    label: "invite code"

  group_id:
    type: String
    label: "group id"

  user_id:
    type: String
    label: "created by"


GroupInvites.helpers {}
