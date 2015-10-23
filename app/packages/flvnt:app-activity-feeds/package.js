
Package.describe({
  name    : 'flvnt:activity-feeds',
  summary : 'activity streams for meteor apps',
  version : '0.0.1',
  documentation : 'README.md'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['server', 'client'];


  api.use([
    'coffeescript',
    'mquandalle:jade@0.4.2',
    'stylus',
    'underscore',
    'jquery',
    'mongo',
    'http',
    'blaze',
    'session',
    'tracker',
    'templating',
    'check',
    'aldeed:collection2@2.3.3',
    'aldeed:simple-schema@1.3.2',
    'dburles:collection-helpers@1.0.3',
    'tmeasday:publish-counts@0.4.0',
    'meteorhacks:subs-manager@1.3.0',
    'meteorhacks:unblock@1.1.0',
    'flvnt:collection-schemas@0.0.1',
    'flvnt:env@0.0.1',
    'flvnt:logger@0.0.1',
    'flvnt:api-utils@0.0.1',
    'flvnt:features@0.0.1'
  ], where);


  api.add_files([
    'lib/activity-feeds-api.coffee',
    'lib/collections/collections.coffee'
  ], where);

  api.add_files([
    'lib/server/methods/methods.coffee',
    'lib/server/publish/notifications-count.coffee',
    'lib/server/publish/notifications.coffee'
  ], ['server']);

  api.add_files([
    'lib/client/subscribe.coffee',
  ], ['client']);


  api.export([
    'Activity',
    'activity_api'
    'notification_count_sub',
    'notifications_sub_handle'
  ], where);

});
