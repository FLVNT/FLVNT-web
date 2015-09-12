
class @GroupInviteAPI

  @create: (opts)->
    logger.info "opts:", opts
    # create group invite
    invite = _.extend(_.pick(opts, "group_id", "user_id"),
      # defaults
    )

    invite_code_id = InviteCodes.create_code_for_group_invite()
    invite.code = invite_code_id
    logger.info "invite ", invite

    result = GroupInvites.insert invite
    logger.info "result:", result

    # add group unto already existing users (that aren't already in the group)
    selector =
      '_id': opts.invitee_fbid
      'groups.id': {$ne: invite.group_id}

    existing = Meteor.users.findOne selector
    logger.info "existing user (not in the group):", existing

    # TODO: create activity for the invitation to appear in notifications tab..

    unless existing?
      logger.info "inviting new user to group.."
      return {
        code: invite.code
        url: "#{env.app_url}/invite/accept/#{invite.code}"
      }

    logger.info "adding invited user to group.."

    selector =
      '_id': opts.invitee_fbid
      'groups.id': {$ne: invite.group_id}

    action =
      $addToSet:
        'groups': {id: invite.group_id, status:'pending'}

    options =
      multi: true

    Meteor.users.upsert selector, action, options

    logger.debug "adding user to group.."
    GroupsAPI.add_pending_member invite.group_id, opts.invitee_fbid

    { code: invite.code, url: "#{env.app_url}/invite/accept/#{invite.code}" }
