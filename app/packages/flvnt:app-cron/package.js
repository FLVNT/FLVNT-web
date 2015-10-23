
Package.describe({
  name    : 'flvnt:app-cron',
  summary : 'flvnt:web bridge to the mrt:cron package',
  version : '0.0.1',
  documentation : 'README.md'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['server'];


  api.use([
    'coffeescript',
    'underscore',
    'check',
    'tracker',
    'http',
    'mongo',
    'mrt:cron@0.0.1',
    'flvnt:env@0.0.1',
    'flvnt:logger@0.0.1',
    'flvnt:app-features@0.0.1',
    'flvnt:app-facebook@0.0.1',
    'flvnt:app-db-migrations@0.0.1',
    'flvnt:app-accounts@0.0.1',
    'flvnt:app-beta-invites@0.0.1'
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


  api.export([
    'CronTasks',
    'cron'
  ]);

});
