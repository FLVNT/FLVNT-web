#: invite code subscription

if Features.ENABLE_INVITECODES

  Tracker.autorun =>

    invite_code_id = Session.get 'invite_code_id'
    if invite_code_id?.length
      Meteor.subscribe 'InviteCodeById', invite_code_id
