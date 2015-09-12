
Package.describe({
  name    : 'flvnt:filepicker-sdk',
  summary : 'filepicker.io javascript sdk loader',
  version : '0.0.1',
  documentation : 'README.md'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['client'];

  api.use([
    'coffeescript',
    'underscore',
    'flvnt:lazyload@0.0.1',
    'flvnt:logger@0.0.1'
  ], where);

  api.add_files([
    'client/lib/filepicker-sdk.coffee'
  ], where);

  api.export('load_filepicker_sdk');
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
  api.imply('flvnt:filepicker-sdk', where, {bare: true});


  api.add_files([
    'tests/exports.coffee',
    'tests/methods.coffee'
  ], where);

});
