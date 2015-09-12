
Package.describe({
  name    : 'flvnt:jquery-touch-events',
  summary : 'jquery-touch-events packaged for meteor',
  version : '0.0.1',
  documentation : 'README.md'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['client'];

  api.use([
    'jquery'
  ], where);

  api.add_files([
    'lib/client/jquery-touch-events.js'
  ], where);

});


Package.on_test(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['client'];

  // standard test helpers..
  api.use([
    'coffeescript', 'tinytest', 'test-helpers', 'coffeescript-test-helper',
    'check',
    'flvnt:app-fixtures'
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
    'flvnt:jquery-touch-events'
  ], where, {bare: true});


  api.add_files([
    'tests/exports.coffee',
    'tests/methods.coffee'
  ], where);

});
