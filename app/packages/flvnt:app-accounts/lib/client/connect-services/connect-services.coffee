
Template.connect_services.events

  'click [data-event="service-connect"]': (e, template)->
    AppAccounts.connect_with_service template.data.service

  'click [data-event="service-disconnect"]': (e, template)->
    AppAccounts.disconnect_service template.data.service
