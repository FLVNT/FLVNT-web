
Package.describe({
  name    : 'flvnt:facebook-sdk',
  summary : 'facebook-sdk javascript loader',
  version : '0.0.1',
  documentation : 'README.md'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['client'];


  api.use([
    'coffeescript',
    'underscore',
    'jquery',
    'flvnt:lazyload@0.0.1',
    'flvnt:logger@0.0.1'
  ], where);


  api.add_files([
    'lib/client/facebook-sdk.coffee'
  ], where);


  api.export('load_facebook_sdk');
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
    'ui',
    'templating'
  ], where);


  // import the package..
  api.imply('flvnt:facebook-sdk@0.0.1', where, {bare: true});


  api.add_files([
    'tests/exports.coffee',
    'tests/methods.coffee'
  ], where);

});
