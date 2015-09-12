
Package.describe({
  name    : 'flvnt:jquery-easing',
  summary : 'jquery-easing packaged for meteor',
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
    'lib/client/jquery.easing.css',
    'lib/client/jquery.easing.js'
  ], where);

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
  api.imply('flvnt:jquery-easing', where, {bare: true});


  api.add_files([
    'tests/exports.coffee',
    'tests/methods.coffee'
  ], where);

});
