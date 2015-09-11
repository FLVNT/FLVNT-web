
Package.describe({
  name    : 'flvnt:env',
  summary : 'flvnt-web environment package',
  version : '0.0.1'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['server'];

  api.use([
    'coffeescript',
    'underscore',
    'json'
  ], ['client', 'server']);

  api.add_files([
    'lib/env-id.coffee'
  ], ['client', 'server']);

  api.add_files([
    'lib/env.coffee'
  ], where);

  api.export('env_id');
  api.export('env');

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
  api.imply('flvnt:env', where, {bare: true});


  api.add_files([
    'tests/exports.coffee',
    'tests/methods.coffee'
  ], where);

});
