
Package.describe({
  name    : 'flvnt:fonts',
  summary : 'flvnt-web public fonts',
  version : '0.0.1',
  documentation : 'README.md'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['client'];

  api.use([
    'coffeescript',
    'underscore',
    'check',
    'flvnt:lazyload@0.0.1',
    'flvnt:logger@0.0.1'
  ], where);


  api.add_files([
    // 'lib/client/api.coffee'
  ], 'client');


  api.export('ApiUtils');

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
    'session',
    'flvnt:logger@0.0.1'
  ], where);


  // import the package..
  api.imply([
    'flvnt:fonts'
  ], where, {bare: true});


  api.add_files([
    'tests/exports.coffee',
    'tests/methods.coffee'
  ], where);

});
