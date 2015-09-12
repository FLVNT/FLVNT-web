
Package.describe({
  name    : 'flvnt:activity-feeds',
  summary : 'activity feeds for meteor apps',
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
    'deps',
    'tracker',
    'flvnt:logger@0.0.1',
    'flvnt:env@0.0.1',
    'aldeed:collection2',
    'aldeed:simple-schema',
    'dburles:collection-helpers',
    'flvnt:collection-schemas@0.0.1',
    'flvnt:api-utils@0.0.1',
    'flvnt:app-features@0.0.1',
    'tmeasday:publish-counts@0.4.0',
    'meteorhacks:subs-manager@1.3.0',
    'meteorhacks:unblock@1.1.0'
  ]);

  api.imply([
    'mongo',
    'aldeed:collection2',
    'aldeed:simple-schema',
    'dburles:collection-helpers',
    'flvnt:collection-schemas@0.0.1'
  ]);


  api.add_files([
    'lib/activity-feeds-api.coffee',
    'lib/collections.coffee'
  ], where);

  api.add_files([
    'lib/server/methods.coffee',
    'lib/server/publish.coffee'
  ], 'server');

  api.add_files([
    'lib/client/subscribe.coffee',
  ], 'client');


  api.export('Activity');
  api.export('activity_api');

});


Package.on_test(function (api, where) {
  where = where || ['client'];

  // standard test helpers..
  api.use([
    'coffeescript', 'tinytest', 'test-helpers', 'coffeescript-test-helper',
    'fixtures'
  ]);


  // package specific..
  api.use([
    'ui',
    'templating'
  ], where);


  // import the package..
  api.imply('flvnt:activity-feeds', where, {bare: true});


  api.add_files([
    'tests/exports.coffee',
    'tests/methods.coffee'
  ], where);

});
