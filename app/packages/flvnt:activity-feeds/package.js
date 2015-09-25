
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
    'session',
    'templating',
    'tracker',
    'blaze',
    'service-configuration',
    'oauth',
    'oauth2',
    'mongo',
    'http',
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
    'lib/server/publish/notifications-counts.coffee',
    'lib/server/publish/notifications.coffee'
  ], 'server');

  api.add_files([
    'lib/client/subscribe.coffee',
  ], 'client');


  api.export([
    'Activity',
    'activity_api'
  ], where);

});


Package.on_test(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['client'];

  // standard test helpers..
  api.use([
    'coffeescript', 'tinytest', 'test-helpers', 'coffeescript-test-helper',
    'flvnt:app-fixtures'
  ]);


  // package specific..
  api.use([
  ], where);


  // import the package..
  api.imply([
    'flvnt:activity-feeds'
  ], where, {bare: true});


  api.add_files([
    'tests/exports.coffee',
    'tests/methods.coffee'
  ], where);

});
