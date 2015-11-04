
# PS: handlebars is wack. why do i have to go through this shit just to do
# a modulo operator!?
UI.registerHelper 'eachrow', (context, options)->

  rv = ""
  every = 4
  if options.data?.every?
    every = options.data.every

  if context and context.length > 0
    for ctx, index in context

      is_mod_zero = index % every is 0
      is_mod_zero_first = is_mod_zero and index is 0
      is_mod_zero_not_first = is_mod_zero and index > 0
      is_last = index is (context.length - 1)

      data = _.extend {}, ctx,
        is_mod_zero: is_mod_zero
        is_mod_zero_first: is_mod_zero_first
        is_mod_zero_not_first: is_mod_zero_not_first
        is_last: is_last

      if is_mod_zero_first
        # rv += '<div class="row">'
        rv += options.fn data
        # rv += '</div>'
      else
        rv += options.fn data

  else
    rv = options.inverse @

  rv
