
Package.describe({
  name    : 'flvnt:api-utils',
  summary : 'flvnt-web common methods used by the server Meteor.method() functions',
  version : '0.0.1',
  documentation : 'README.md'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['client', 'server'];


  api.use([
    'coffeescript',
    'underscore',
    'check',
    'flvnt:logger@0.0.1'
  ], where);


  api.add_files([
    'lib/server/api.coffee'
  ], 'server');

  api.add_files([
    'lib/client/api.coffee'
  ], 'client');


  api.export('ApiUtils');

});


Package.on_test(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['client', 'server'];

  // standard test helpers..
  api.use([
    'coffeescript', 'tinytest', 'test-helpers', 'coffeescript-test-helper',
    'flvnt:app-fixtures',
  ], where);


  // package specific..
  api.use([
  ], where);


  // import the package..
  api.imply('flvnt:api-utils', where, {bare: true});


  api.add_files([
    'tests/exports.coffee',
    'tests/methods.coffee'
  ], where);

});
