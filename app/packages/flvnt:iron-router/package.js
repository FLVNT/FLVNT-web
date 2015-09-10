
Package.describe({
  name    : 'flvnt:iron-router',
  summary : 'flvnt-web bridge for the iron-router meteor.js package',
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
    'session'
  ], ['client', 'server']);

  api.add_files([
    'lib/client/routes-config.coffee'
  ], 'client');

  api.add_files([
    'lib/server/routes/unsubscribe-hook.coffee'
  ], 'server');

  api.use([
    'ui', 'spacebars', 'blaze', 'templating'
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
  api.imply('flvnt:iron-router', where, {bare: true});


  api.add_files([
    'tests/exports.coffee',
    'tests/methods.coffee'
  ], where);

});
