
Template.index.onRendered = ->


Template.index.helpers


Template.index.events
  'mouseover .tile-card': (e, template)->
    $e = $ e.currentTarget
    $e.addClass('fadeout')
    template.data.revert = false

  'mouseout .tile-card': (e, template)->
    $e = $ e.currentTarget
    $e.removeClass('fadeout')
    template.data.revert = true

  'click .tile-card': (e, template)->
    $e = $ e.currentTarget
    $e.removeClass('fadeout').addClass('fadein')

    revert = ->
      Meteor.setTimeout (->
        if not template.data.revert
          template.data.revert = true
          return revert()
        else
          $e.removeClass('fadeout').removeClass('fadein')
      ), 500
    revert()
