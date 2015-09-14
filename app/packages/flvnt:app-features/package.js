
Package.describe({
  name    : 'flvnt:app-features',
  summary : 'flvnt:web feature toggles',
  version : '0.0.1'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['server', 'client'];

  api.use([
    'coffeescript',
    'underscore',
    'flvnt:logger@0.0.1',
    'flvnt:env@0.0.1'
  ], where);


  api.add_files([
    'lib/features.coffee'
  ], where);


  api.export('Features');

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
    'flvnt:app-features'
  ], where, {bare: true});


  api.add_files([
    'tests/exports.coffee',
    'tests/methods.coffee'
  ], where);

});
