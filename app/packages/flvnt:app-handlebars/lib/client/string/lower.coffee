
#
# lowercase a string.
#
UI.registerHelper 'lower', (context, options)->
  context.toLowerCase() if context?.toLowerCase?
