
Package.describe({
  name    : 'flvnt:device-js',
  summary : 'device.js packaged for meteor (matthewhudson.me/projects/device.js/)',
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
    'flvnt:logger@0.0.1',
    'flvnt:bootstrap@0.0.1'
  ], where);


  api.add_files([
    'lib/client/device.coffee'
  ], where);


  api.export('device', where);
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
  api.imply('flvnt:device-js', where, {bare: true});


  api.add_files([
    'tests/exports.coffee',
    'tests/methods.coffee'
  ], where);

});
