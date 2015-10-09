
#: force value to be current date (on server) upon insert
#: and prevent updates thereafter.
SchemaHelpers.created_at = ->
  type       : Date
  label      : "created at"
  optional   : true
  denyUpdate : false

  autoValue: ->
    if @isInsert
      new Date()

    else if @isUpsert
      {$setOnInsert: new Date}

    else
      @unset()


#: force value to be current date (on server) upon update
#: and don't allow it to be set upon insert.
SchemaHelpers.updated_at = ->
  type       : Date
  label      : "updated at"
  optional   : true
  denyInsert : true

  autoValue: ->
    if @isUpdate
      new Date()
