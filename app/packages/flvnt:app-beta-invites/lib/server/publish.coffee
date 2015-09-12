
# publishes invite codes accepted by a user
Meteor.publish "AcceptedInviteCode", (user_id) ->
  check user_id, String

  @unblock()
  pub = InviteCodes.find_accepted_by_user user_id
  return @ready() if not pub?
  pub


# publish InviteCode by _id
Meteor.publish "InviteCode", (_id) ->
  check _id, String

  @unblock()
  pub = InviteCodes.find '_id': _id
  return @ready() if not pub?
  pub
