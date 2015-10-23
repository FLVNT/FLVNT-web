
Meteor.methods

  create_invite_signup: (name, email, invite_queue)->
    invite_queue = 'private-alpha' unless invite_queue?.length

    ApiUtils.validate_non_empty_field_exists 'name', name
    ApiUtils.validate_non_empty_field_exists 'email', email

    try
      options =
        name: name
        email: email
        invite_queue: invite_queue

      invite_signup: InviteSignups.insert options
      status: "ok"
    catch e
      ApiUtils.bubble_api_error e, 'unable to create invite signup'


  # update invite code to mark it as used.
  accept_invite_code: (invite_code_id)->
    logger.info 'api.accept_invite_code:', invite_code_id

    ApiUtils.validate_non_empty_field_exists 'invite-code-id', invite_code_id
    user = ApiUtils.get_meteor_user_or_invalidate()

    try
      options =
        accepted_by_id: user._id
        invite_code_id: invite_code_id

      result: InviteCodes.accept_invite_code options
      status: "ok"
    catch e
      ApiUtils.bubble_api_error e, 'unable to accept invite code'


  create_group_invite: (group_id, fbid) ->
    ApiUtils.validate_non_empty_field_exists 'group-id', group_id
    ApiUtils.validate_non_empty_field_exists 'friend facebook id', fbid
    user = ApiUtils.get_meteor_user_or_invalidate()

    # TODO: validations:
    # - group is not read-only
    # - user can invite people to group

    try
      options =
        user_id      : user._id
        group_id     : group_id
        invitee_fbid : fbid
      GroupInviteAPI.create options
    catch e
      ApiUtils.bubble_api_error e, 'unable to create group invite'


  # method to manually configure a user account to be able to login with the
  # meteor-accounts-password package.
  # - see: github.com/meteor/meteor/blob/master/packages/accounts-password
  complete_account_setup: (name, email, password)->
    user = ApiUtils.get_meteor_user_or_invalidate()

    options =
      name: name
      email: email
      password: password

    try
      result: user.complete_account_setup options
      status: "ok"
    catch e
      ApiUtils.bubble_api_error e, 'unable to create invite signup'
