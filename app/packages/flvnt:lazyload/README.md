flvnt:lazyload
==============

lazy-load javascript files on the client using `<script>` tag injection


USAGE:
------

1. load javascript source by url, then hook into the callback when it's loaded:


  LazyLoad '//google.com/test.js', (err, tag)->
    if err?
      console.error err
    else
      console.info 'script loaded:', tag


2. load a javascript src by url, then reference the `<script>` tag to manipulate
it directly:


    script_tag = LazyLoad 'https://www.youtube.com/iframe_api'
    $(script_tag).remove()
