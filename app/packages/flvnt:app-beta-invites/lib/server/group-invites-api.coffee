
class GroupInviteAPI

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
        'code': invite.code
        'url': "#{env.app_url}/invite/accept/#{invite.code}"
      }

    logger.info "adding invited user to group.."

    selector =
      '_id': opts.invitee_fbid
      'groups.id': {$ne: invite.group_id}

    action =
      $addToSet:
        'groups':
          'id': invite.group_id
          'status': 'pending'

    options =
      multi: true

    Meteor.users.upsert selector, action, options

    logger.debug "adding user to group.."
    Groups.add_pending_member invite.group_id, opts.invitee_fbid

    {
      'code': invite.code
      'url': "#{env.app_url}/invite/accept/#{invite.code}"
    }


  #: accept a group that you've been inited to
  @accept = (options) ->
    opts = _.extend(_.pick(options, "group_id", 'user_id'), {
      # defaults / overrides
    })

    query =
      '_id': opts.group_id
      'members.id': opts.user_id
    logger.info 'groups_api.coffee accept:', opts, 'query', query

    update =
      $set: {'members.$.status': 'active'}

    #: set user to active on group
    Groups.update query, update

    #: set group on user to active
    # TODO: implement this style of update / selector for working with post images
    query  =
      '_id': opts.user_id
      'groups.id': opts.group_id

    action =
      set: {'groups.$.status': 'active'}

    Meteor.users.update query, action


  #: reject a group that you've been inited to
  @reject = (options) ->
    opts = _.extend(_.pick(options, "group_id"),
      user_id: Meteor.userId()
    )

    logger.info 'groups_api.coffee reject:', opts

    #: remove user from group
    selector =
      '_id': opts.group_id

    update =
      $pull:
        'members': {'id': opts.user_id}
        'member_ids': opts.user_id

    Groups.update selector, update

    # remove group from user
    selector =
      '_id': opts.user_id

    update =
      $pull:
        'groups': {'id': opts.group_id}

    Meteor.users.update selector, update

