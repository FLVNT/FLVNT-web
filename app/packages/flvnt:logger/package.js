
Package.describe({
  name: 'flvnt:logger',
  summary: 'flvnt-web logger packaged for meteor.js',
  version: '0.0.1'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['client', 'server'];

  api.use([
    'coffeescript',
    'underscore',
    'logging',
    'ejson',
    'flvnt:env@0.0.1'
  ], where);

  api.use([
    'meteor-winston-sentry'
  ], 'server');


  api.add_files([
    'lib/server/logger.coffee'
  ], 'server');

  api.add_files([
    'lib/client/logger.coffee'
  ], 'client');


  api.export('logger');

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
  api.imply('flvnt:logger', where, {bare: true});

  api.add_files([
    'tests/exports.coffee',
    'tests/methods.coffee'
  ], where);

});
