
Template.index.helpers


Template.index.events
  'mouseover .tile-card': (e, template)->
    template.$('.tile-card').addClass('fadeout')

  'mouseout .tile-card': (e, template)->
    template.$('.tile-card').removeClass('fadeout')
