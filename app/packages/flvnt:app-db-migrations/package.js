
Package.describe({
  name    : 'flvnt:app-db-migrations',
  summary : 'run, manage db schema migrations in a meteor app',
  version : '0.0.1',
  documentation : 'README.md'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['server', 'client'];


  api.use([
    'coffeescript',
    'underscore',
    'jquery',
    'mongo',
    'http',
    'tracker',
    'session',
    'aldeed:collection2@2.3.3',
    'aldeed:simple-schema@1.3.2',
    'dburles:collection-helpers@1.0.3',
    'flvnt:logger@0.0.1',
    'flvnt:env@0.0.1',
    'flvnt:app-features@0.0.1',
    'flvnt:collection-schemas@0.0.1',
    'flvnt:api-utils@0.0.1',
    'tmeasday:publish-counts@0.4.0',
    'meteorhacks:subs-manager@1.3.0',
    'meteorhacks:unblock@1.1.0'
  ], where);


  api.add_files([
    'lib/collections/collections.coffee'
  ], where);

  api.add_files([
    'lib/server/startup.coffee'
  ], 'server');

  api.add_files([
  ], 'client');


  api.export('Migrations');
  api.export('Migration');

});


Package.on_test(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['client', 'server'];

  // standard test helpers..
  api.use([
    'coffeescript', 'tinytest', 'test-helpers', 'coffeescript-test-helper',
    'flvnt:app-fixtures'
  ], where);


  // package specific..
  api.use([
  ], where);


  // import the package..
  api.imply([
    'flvnt:app-db-migrations'
  ], where, {bare: true});


  api.add_files([
    'tests/exports.coffee',
    'tests/methods.coffee'
  ], where);

});
