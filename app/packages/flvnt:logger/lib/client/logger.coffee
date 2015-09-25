
_console = ->
  log   : -> {}
  info  : -> {}
  warn  : -> {}
  error : -> {}


_stringify = ->
  _.map arguments, (arg) ->
    console.info 'arg:', arg
    JSON.stringify arg


_console =
  info: ->
    args = _stringify.apply @, arguments
    console.info.call(args)

  warn: ->
    args = _stringify.apply @, arguments
    console.warn.call(args)

  log: ->
    args = _stringify.apply @, arguments
    console.info.call(args)

  error: ->
    args = _stringify.apply @, arguments
    console.error.call(args)


if console?
  logger = console
else
  logger = _console()

