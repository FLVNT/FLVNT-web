
SchemaHelpers.soft_delete = ->
  type     : Boolean
  label    : "soft deleted"
  optional : true
  autoValue: ->
    return false if @isInsert
