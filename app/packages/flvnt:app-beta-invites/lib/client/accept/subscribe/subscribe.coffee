# invite code subscription

if Features.ENABLE_INVITECODES

  Tracker.autorun =>
    invite_code_id = Session.get 'accept_invite_code_id'
    return unless invite_code_id?.length

    Meteor.subscribe 'AcceptInviteCode', invite_code_id
