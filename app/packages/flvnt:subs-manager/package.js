
Package.describe({
  name    : 'flvnt:subs-manager',
  summary : 'flvnt-web bridge to meteorhacks:subs-manager',
  version : '0.0.1'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['client', 'server'];


  api.use([
    'coffeescript',
    'underscore',
    'flvnt:logger@0.0.1',
    'meteorhacks:subs-manager@1.3.0'
  ]);

  api.add_files([
    'lib/client/subs-manager.coffee'
  ], where);


  api.export('subs');
  api.export('notifications_subs');

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
  api.imply('flvnt:schema', where, {bare: true});


  api.add_files([
    'tests/exports.coffee',
    'tests/methods.coffee'
  ], where);

});
