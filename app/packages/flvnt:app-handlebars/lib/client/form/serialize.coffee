
Template.serialize_inputs = (template)->
  rv = {}
  _.map template.$('input'), (input)=>
    val = $(input).val()
    val = $.trim(val) if _.isString val
    rv["#{input.name}"] = val
  rv
