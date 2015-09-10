
# TODO convert to 0.8, currently broken, hacked with a template helper
UI.registerHelper "abbreviate_name", (name) ->
  abbreviate_name name


UI.registerHelper "initial_name", (name) ->
  initial_name name


abbreviate_name = (name) ->
  return '' if not name? or name.length < 1

  names = name.split ' '
  first = names[0]
  last = names.pop() if names.length > 1

  return "#{first}" if not last?

  initial = initial_name last
  "#{first} #{initial}"


initial_name = (name) ->
  return '' if not name? or name.length < 1
  "#{name[0]}."
