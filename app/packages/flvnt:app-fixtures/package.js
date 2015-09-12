
Package.describe({
  name    : 'flvnt:app-fixtures',
  summary : 'flvnt-web test fixtures.',
  version : '0.0.1',
  documentation : 'README.md',
  debugOnly: true
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['client', 'server'];

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
  api.versionsFrom('1.1.0.2');
  where = where || ['client', 'server'];

  // standard test helpers..
  api.use([
    'coffeescript', 'tinytest', 'test-helpers', 'coffeescript-test-helper',
    'check'
  ], where);


  // package specific..
  api.use([
    'underscore',
    'jquery',
    'ui',
    'blaze',
    'templating',
    'session'
  ], where);


  // import the package..
  api.imply([
    'flvnt:app-fixtures'
  ], where, {bare: true});


  api.addFiles([
    'tests/exports.coffee'
  ], where);

});
