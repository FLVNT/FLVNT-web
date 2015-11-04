
#: enqueues a task worker to import the user's service data
AppAccounts.on_connect_with_service = (data)->
  # JobsAPI.add 'on connect service',
  #   _id: data._id
  #   service: data.service


#: removes a connected third party service from a user.services document.
AppAccounts.disconnect_service = (service)->
  attrs = {}
  attrs["services.#{service}"] = ''
  Meteor.users.$unset Meteor.userId(), attrs
  # TODO: revisit
  # JobsAPI.add 'disconnect user from service',
  #   _id: Meteor.userId()
  #   service: service
