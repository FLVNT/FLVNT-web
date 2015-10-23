
# route for sendgrid unsubscribe-hook
Router.map ->
  @route 'sendgrid_unsubscribe_hook',
    where: 'server'
    path: '/notifications/email/unsubscribe'
    fastrender: true

    action: ->
      email = @request.body.email
      event = @request.body.event
      return if event != 'unsubscribe'

      query =
        'emails.address': email

      action =
        $set:
          'profile.app_email_subscribed': false

      Meteor.users.update query, action

      @response.writeHead 200, {'Content-Type': 'text/html'}
      @response.end 'unsubscribed'
