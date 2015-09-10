
Router.map ->
  @route 'unsubscribe_hook',
    where: 'server'
    path: '/email/unsubscribed'
    action: ->
      body = @request.body
      email = body.email
      event = body.event
      return if event isnt 'unsubscribe'

      action =
        $set:
          'profile.app_email_subscribed': false
      Meteor.users.update {'emails.address': email}, action

      @response.writeHead 200, {'Content-Type': 'text/html'}
      @response.end 'unsubscribed'
