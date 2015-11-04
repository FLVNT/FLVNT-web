

#: collection of codes created by app-admins for signups in an
#: invitequeue.
InviteCodes = new Mongo.Collection "invite_codes", {}


InviteCodes.attachSchema new SimpleSchema
  created_at: SchemaHelpers.created_at()
  updated_at: SchemaHelpers.updated_at()

  reusable:
    type: Boolean
    label: "is reusable?"

  created_by:
    type: String
    label: "created by"
    autoValue: ->
      try
        return @userId
      catch e
        logger.error e, e.stack

  #: the `_id` of the invite signup the code was created for
  invite_signup_id:
    type: String
    label: "invite signup id"
    optional: true

  invite_type:
    type: String
    label: "invite type"
    allowedValues: ['signup', 'group']

  scheduled_send_date:
    type: Date
    label: "scheduled send date"
    optional: true

  sent_at:
    type: Date
    label: "sent at"
    optional: true

  "accepted.$.at":
    type: Date
    label: "accepted at"

  "accepted.$.id":
    type: String
    label: "user id"


InviteCodes.helpers
  created_by: ->
    Meteor.users.findOne '_id': @user_id

  created_by_name: ->
    @created_by()?.profile?.name

  send: ->
    return unless @invite_signup_id?

    signup = InviteSignups.findOne '_id': @invite_signup_id
    return unless signup?

    recipient = signup.email
    name = signup.name

    logger.info 'sending invite code:', name, recipient

    try
      # use the existing google appengine app. we have free $$
      # and it's already configured from the current unvael splash page.
      Meteor.http.post 'http://gae.unvael.com/api/mail/send',
        data:
          recipient: recipient
          template_id: "invitecode-created"
          # todo: replace with mixpanel api
          invite_code_url: "#{Meteor.settings.app_url}/invite/accept/#{@_id}"

      # mark invite as sent by adding timestamp
      update = $set: {'sent_at': new Date()}
      InviteCodes.update {_id: @_id}, update
      true
    catch e
      logger.error e.stack
      false


InviteCodes.create_code = (options)->
  # query for an existing invitecode for the signup..
  doc = InviteCodes.findOne 'invite_signup_id': options.invite_signup_id
  if doc?
    throw new Meteor.Error("invitecode already exists for signup: #{options.invite_signup_id}")

  doc =
    invite_type: 'signup'
    invite_signup_id: options.invite_signup_id
    scheduled_send_date: options.scheduled_send_date
    reusable: options.reusable
    accepted: []
  @insert doc


InviteCodes.create_code_for_group_invite = ->
  doc =
    invite_type: 'group'
    reusable: true
    accepted: []
  @insert doc


InviteCodes.find_accepted_by_user = (user_id)->
  query =
    'accepted':
      $elemMatch:
        'id': user_id

  InviteCodes.find query


#: updates an InviteCode document
InviteCodes.accept_invite_code = (options)->
  invite_code = @findOne '_id': options.invite_code_id
  logger.info 'invitecode.accept_invite_code:', invite_code

  unless invite_code?
    throw new Meteor.Error("sorry, invite code not found: #{options.invite_code_id}")

  #: check the code is not already accepted, or allows more than one
  unless invite_code.reusable
    if invite_code.accepted.length
      throw new Meteor.Error("sorry, invite code has already been used: #{options.invite_code_id}")

  #: update the group doc to link the pending member..
  group_invite = GroupInvites.findOne 'code': invite_code._id
  logger.info 'group_invite:', group_invite
  if group_invite?
    group = Groups.findOne '_id': group_invite.group_id
    group.add_pending_member options.accepted_by_id
    group.add_pending_group_to_user options.accepted_by_id

  query =
    '_id': invite_code._id

  update =
    $addToSet:
      'accepted':
        'id': options.accepted_by_id
        'at': new Date()

  @update query, update


#: returns true/false if an InviteCode is valid, and can be used to create
#: an account
InviteCodes.can_accept_invite = (invite_code_id)->
  invite_code = @findOne '_id': invite_code_id
  # code does not exist
  unless invite_code?
    logger.warn "invite code not found in db", invite_code_id
    return false

  # check if code has doesn't allow more than one, and hasn't already been used
  unless not invite_code.reusable == true
    if invite_code.accepted?.length
      logger.warn "invite code has already been used.. maybe try logging in?"
      return false

  # TODO check for corresponding InviteSignup / GroupInvite

  logger.info 'invite code valid to accept:', invite_code_id
  true


#: sends unsent invites that are past due
InviteCodes.send_eligible_invites = ->
    query =
      'scheduled_send_date': {$lt: new Date()}
      'sent_at': null
    eligible = InviteCodes.find query

    logger.info 'send_eligible_invites count:', eligible.count()

    eligible.forEach (invite)->
      try
        invite.send()
      catch e
        logger.error e.stack


if Meteor.settings.public?.fb_popup_rhone
  InviteCodes.allow
    insert: (userId, doc)->
      return (
        userId &&
        doc.invite_type == 'group'
      )

    fetch: ['invite_type']
