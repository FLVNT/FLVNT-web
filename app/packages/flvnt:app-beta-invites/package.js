
Package.describe({
  name    : 'flvnt:app-beta-invites',
  summary : 'flvnt-web app beta invites for meteor.js',
  version : '0.0.1',
  documentation: 'README.md'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['client', 'server'];

  api.use([
    'coffeescript',
    'underscore',
    'jquery',
    'templating',
    'ui',
    'session',
    'check',
    'flvnt:logger@0.0.1'
  ], where);


  api.add_files([
  ], 'server');

  api.add_files([
  ], 'client');


});


Package.on_test(function (api, where) {
  where = where || ['client', 'server'];

  // standard test helpers..
  api.use([
    'coffeescript', 'tinytest', 'test-helpers', 'coffeescript-test-helper',
    'fixtures', 'check'
  ], where);


  // package specific..
  api.use([
    'ui',
    'templating',
  ], ['client']);


  // import the package..


  api.add_files([
    'tests/exports.coffee',
    'tests/methods.coffee'
  ], where);

});