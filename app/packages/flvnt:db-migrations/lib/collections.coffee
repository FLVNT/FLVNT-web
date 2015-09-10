
Migrations = new Mongo.Collection "migrations", {}

Migrations.attachSchema new SimpleSchema
  created_at: SchemaHelpers.updated_at()

  'collection':
    type: String
    label: "collection name"

  'name':
    type: String
    label: "name"

  'actions':
    type: [String]
    label: "actions"

  'target_env':
    type: String
    label: "target environment id"
    allowedValues: ['local', 'stage', 'prod']
    optional: true

  'run_at':
    type: Date
    label: "run at"
    optional: true

  'run_result':
    type: Number
    label: "run result"
    optional: true


Migrations.helpers

  run: (callback)->
    return if @has_run()

    result = @run_action @q()
    @done result, callback

  # returns True/False ..
  has_run: ->
    # query for existing migration doc..
    existing = Migrations.findOne {name: @name}
    return existing?

  update: (q, overrides)->
    # TODO: query migration docs, for each, exec fn()
    query = _.extend(q, overrides)
    _c = root[@collection]
    _c.update query.selector, query.action, query.options

  q: ->
    {
      selector: {}
      action  : {}
      options : {}
    }

  done: (result, callback)->
    logger.info 'migration completed:', @collection, @actions
    # update migration doc..
    @upsert {name: @name}, info
    callback result, doc


Migrations.define = (options)->
  doc = _.extend(_.pick(options, "collection", 'name', 'actions', 'target_env'), {
    # defaults / overrides
    # group_id:
    # user_id:
  })
  @upsert {name: options.name}, {$set: doc}
  doc


Migrations.run = ->
  _c = root[@collection]
  cursor = _c.find {}
  cursor.forEach (migration) =>
    return if migration.run_at?

    migration.run (result, doc)->
      logger.info 'migration run:', migration.name, result, doc

      action =
        $set:
          'run_at': new Date
          'run_result': result

      @upsert {_id: migration._id}, action
