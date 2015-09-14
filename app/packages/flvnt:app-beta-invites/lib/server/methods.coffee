
Meteor.methods

  create_invite_signup: (name, email, invite_queue)->
    invite_queue = 'private-alpha' if not invite_queue?.length

    ApiUtils.validate_non_empty_field_exists 'name', name
    ApiUtils.validate_non_empty_field_exists 'email', email

    rv = status: "ok"
    try
      options =
        name: name
        email: email
        invite_queue: invite_queue
      rv.invite_signup = InviteSignups.create_signup options
    catch e
      ApiUtils.bubble_api_error e, 'unable to create invite signup'
    rv


  # update invite code to mark it as used.
  accept_invite_code: (invite_code_id)->
    logger.info 'api.accept_invite_code:', invite_code_id

    ApiUtils.validate_non_empty_field_exists 'invite-code-id', invite_code_id

    rv = status: "ok"
    try
      options =
        accepted_by_id: Meteor.userId()
        invite_code_id: invite_code_id
      rv.result = InviteCodes.accept_invite_code options
    catch e
      ApiUtils.bubble_api_error e, 'unable to accept invite code'
    rv


  create_group_invite: (group_id, fbid) ->
    ApiUtils.validate_non_empty_field_exists 'group-id', group_id
    ApiUtils.validate_non_empty_field_exists 'friend facebook id', fbid

    # TODO: validations:
    # - group is not read-only
    # - user can invite people to group

    try
      options =
        user_id: Meteor.userId()
        group_id: group_id
        invitee_fbid: fbid
      GroupInviteAPI.create options
    catch e
      ApiUtils.bubble_api_error e, 'unable to create group invite'
