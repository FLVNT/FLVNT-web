
#
# truncate words in a string over a specified character length.
# TODO: i expect this to be potentially costly with memory if used
# hundreds/thousands of times for the same page.
#
UI.registerHelper "truncate_words_over", (len, str) ->
  if not str? or str.length < 1
    return str or ''

  words = str.split ' '
  for word, index in words when word.length > len
    words[index] = "<span title='#{word}'>"
    words[index] += word.autoLink {
      callback: (url)=>
        label = url.substr 0, len
        "<a href='#{url}'>#{label}</a>"
    }
    # todo: replace with ellipses html entity code
    words[index] += '...'
    words[index] += "</span>"

  return new Spacebars.SafeString(words.join ' ')


#
# truncate a string over a specified character length.
#
UI.registerHelper "truncate_str", (str, len) ->
  if not str? or str?.length < 1
    return str or ''

  if str?.length > len and str?.length > 0

    new_str = str + " "
    new_str = str.substr 0, len
    new_str = str.substr 0, new_str.lastIndexOf(" ")
    new_str = (if (new_str.length > 0) then new_str else str.substr(0, len))

    # todo: replace with ellipses html entity code
    return new Spacebars.SafeString("#{new_str}...")
  str or ''

