
# schema-helpers:  reusable functions used with the packages:
# - aldeed:collection2
# - dburles:collection-helpers

SchemaHelpers = {}


# force value to be current date (on server) upon insert
# and prevent updates thereafter.
SchemaHelpers.created_at = ->
  return {
    type: Date
    label: "created at"
    denyUpdate: false
    optional: true

    autoValue: ->
      if @isInsert
        new Date()

      else if @isUpsert
        {$setOnInsert: new Date}

      else
        @unset()
    }


# force value to be current date (on server) upon update
# and don't allow it to be set upon insert.
SchemaHelpers.updated_at = ->
  return {
    type: Date
    label: "updated at"
    denyInsert: true
    optional: true

    autoValue: ->
      if @isUpdate
        new Date()
  }