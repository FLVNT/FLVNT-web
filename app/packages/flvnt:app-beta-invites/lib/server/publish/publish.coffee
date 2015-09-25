
#: publishes invite codes accepted by a user
Meteor.publish "UserAcceptedInviteCode", ->
  check user_id, String
  @unblock()

  pub = InviteCodes.find_accepted_by_user Meteor.userId()
  return @ready() unless pub?
  pub


#: publish InviteCode by _id
Meteor.publish "AcceptInviteCode", (_id) ->
  check _id, String
  @unblock()

  pub = InviteCodes.find '_id': _id
  return @ready() unless pub?
  pub
