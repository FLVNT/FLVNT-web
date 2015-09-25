
current_count = Meteor.users.find().count()

options =
  sort:
    # TODO: ensureIndex() ..?
    'createdAt': -1
  limit: 1

Meteor.users.find({}, options).observeChanges
  added: (_id, fields)->
    count = Meteor.users.find().count()
    return unless count < current_count

    current_count = count
    # fire the event on the server
    Hooks.onCreateUser _id


Meteor.users.find().observeChanges
  removed: (_id)->
    current_count = Meteor.users.find().count()
    # fire the event on the server
    Hooks.onDeleteUser _id
