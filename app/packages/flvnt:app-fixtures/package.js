
Package.describe({
  name    : 'flvnt:app-fixtures',
  summary : 'flvnt-web test fixtures.',
  version : '0.0.1',
  documentation: 'README.md',
  debugOnly: true
});


Package.on_use(function (api, where) {
  where = where || ['client', 'server'];
  api.versionsFrom('1.1.0.2');

  api.use([
    'coffeescript',
    'underscore'
  ], where);

  api.addFiles([
    'lib/fixtures.coffee'
  ], where);

  api.export('Fixtures');

});


Package.onTest(function (api, where) {
  where = where || ['client', 'server'];

  // standard test helpers..
  api.use([
    'coffeescript', 'tinytest', 'test-helpers', 'coffeescript-test-helper'
  ], where);


  // package specific..
  api.imply([
    'flvnt:app-fixtures'
  ], where, {bare: true});

  api.addFiles([
    'tests/exports.coffee'
  ], where);

});
