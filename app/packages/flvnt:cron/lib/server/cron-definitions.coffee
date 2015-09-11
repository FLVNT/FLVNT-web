
cron = null


Meteor.startup =>
  return unless Features.CRON.ENABLED

  events =
    "0 9 * * *"  : CronTasks.refresh_facebook_friends
    "0 19 * * *" : CronTasks.send_eligible_invites

  if Features.NOTIFICATION_DIGEST.ENABLED
    events["0 9 * * 4"]  = CronTasks.send_daily_active_user_digest_emails
    events["0 19 * * 4"] = CronTasks.send_weekly_active_user_digest_emails

  cron = new Meteor.Cron
    events: events
