
Package.describe({
  name    : 'flvnt:cron',
  summary : 'flvnt:web bridge to the mrt:cron package',
  version : '0.0.1',
  documentation : 'README.md'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['server'];

  api.use([
    'livedata',
    'coffeescript',
    'underscore',
    'livedata',
    'flvnt:logger@0.0.1',
    'flvnt:app-features@0.0.1',
    'mrt:cron@0.0.1'
  ], where);

  api.add_files([
    'lib/server/cron-tasks.coffee',

    // add task handlers..
    // TODO: use node path module to dynamically source modules
    // 'lib/server/tasks/refresh_facebook_friends.coffee',
    // 'lib/server/tasks/send_eligible_invites.coffee',
    // 'lib/server/tasks/send_weekly_active_user_digest_emails.coffee',
    // 'lib/server/tasks/send_daily_active_user_digest_emails.coffee',

    'lib/server/cron-definitions.coffee'
  ], where);

  api.export('CronTasks');
  api.export('cron');

});
