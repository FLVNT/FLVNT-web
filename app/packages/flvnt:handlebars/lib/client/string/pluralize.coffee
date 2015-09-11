
# fairly stupid pluralizer
UI.registerHelper "pluralize", (n, str) ->
  if n is 1
    return "1 #{str}"
  else
    return "#{n} #{str}s"
