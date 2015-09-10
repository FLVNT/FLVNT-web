
class Migration

  _id: null
  name: null
  collection: null
  collection_id: null
  actions: null
  target_env: null

  initialize: (options) ->
    @_id = options._id
    @name = options.name
    @collection = options.collection
    @collection_id = options.collection_id
    @actions = options.actions
    @target_env = options.target_env
