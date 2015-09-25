
#: callback hook when a new user oauths through facebook connect
# TODO: investigate pattern here: https://github.com/gadicc/meteor-accounts-merge/blob/master/accounts-merge.js
Accounts.onCreateUser (options, user)->
  # logger.info "Accounts.onCreateUser options:", options
  if not user.services.facebook? then return user  # skip other services

  #: set the invite_code_id
  # if not options.query.invite_code?.length
  #   throw new Meteor.Error "can't create account without an invite code.."
  # user.invite_code_id = options.query.invite_code

  # logger.info "user connected to facebook:", user.services.facebook, user.invite_code_id
  logger.info "user connected to facebook:", user.services.facebook
  user = UserFacebook.user_account user, options

  #: alias the user to mixpanel..
  #if options.query.mp_id?.length
  #  Mp.alias_user options.query.mp_id, user._id

  user


#: callback hook after onCreateUser is called
#: multiple providers hack :
#: create a user for facebook connections by returning true,
#: otherwise, return false so a new user isn't created for
#: soundcloud + youtube providers.  then updates the user to
#: append initial service data to the user.services[service] document.
#
Accounts.validateNewUser (user)->
  logger.info "Accounts.validateNewUser", "arguments:", arguments

  #: is facebook oauth
  if user.services.facebook?
    fbid = user.services.facebook.id
    logger.info "creating new user account.."

    #: check for an invite_code_id set from accessing an invite code route,
    #: and query for an invitecode to allow the user to create an account
    # if invite_code_id?.length
    #   return true

    # invite_code = InviteCodes.findOne _id: user.invite_code_id
    # if not invite_code?
    #   logger.warn "invite code not found for the user: #{fbid}"
    #   throw new Meteor.Error "invite code not found for the user: #{fbid}"
    # else
    #   return true

    return true

  else
    #: update the user document with the secondary providers.
    AppAccounts.add_service_connection user, (err, rv) =>
      logger.info "user connected to:", rv.service
      @on_connect_with_service rv

    #: return false, since we don't want a new user created for the service
    return false


#: copy a service's profile properties and update and existing user doc
AppAccounts.add_service_connection = (user, callback) ->
  _id = Meteor.userId()
  attrs = {}

  # TODO: migrate to use underscore .find()
  # TODO: where is config.accounts coming from .. ?
  for provider in config.accounts.service_providers
    if user.services[provider]?
      service = provider
      # todo: filter out unnecessary fields
      _.each user.services[service], (value, key)->
        attrs["services.#{service}.#{key}"] = value
      break

  Meteor.users.$set _id, attrs

  result =
    '_id': _id
    'service': service

  if callback?
    callback null, result

  else
    result
