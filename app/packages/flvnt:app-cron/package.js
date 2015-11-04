
Package.describe({
  name    : 'flvnt:app-cron',
  summary : 'flvnt:web bridge to the mrt:cron package',
  version : '0.0.1',
  documentation : 'README.md'
});


Package.on_use(function (api) {
  api.versionsFrom('1.1.0.2');


  api.use([
    'coffeescript',
    'mquandalle:jade@0.4.2',
    'stylus',
    'underscore',
    'jquery',
    'tracker',
    'session',
    'check',
    'blaze',
    'templating',
    'mongo',
    'ddp',
    'http'
  ], ['server']);

  api.use([
    'oauth',
    'oauth2',
    'service-configuration',
    'accounts-base'
  ], ['server']);

  api.use([
    "aldeed:collection2@2.3.3",
    "aldeed:simple-schema@1.3.2",
    "dburles:collection-helpers@1.0.3",
    "meteorhacks:unblock@1.1.0",
    "tmeasday:publish-counts@0.4.0"
  ], ['server']);

  api.use([
    'mrt:cron@0.0.1',
    'flvnt:env@0.0.1',
    'flvnt:logger@0.0.1',
    'flvnt:app-features@0.0.1',
    'flvnt:app-facebook-sdk@0.0.1',
    'flvnt:app-db-migrations@0.0.1',
    'flvnt:app-accounts@0.0.1',
    'flvnt:app-beta-invites@0.0.1'
  ], ['server']);


  api.add_files([
    'lib/server/cron-tasks.coffee',

    // add task handlers..
    // TODO: use node path module to dynamically source modules
    // 'lib/server/tasks/refresh_facebook_friends.coffee',
    // 'lib/server/tasks/send_eligible_invites.coffee',
    // 'lib/server/tasks/send_weekly_active_user_digest_emails.coffee',
    // 'lib/server/tasks/send_daily_active_user_digest_emails.coffee',

    'lib/server/cron-definitions.coffee'
  ], ['server']);


  api.export([
    'CronTasks',
    'cron'
  ]);

});
