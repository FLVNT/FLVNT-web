
Package.describe({
  name    : 'flvnt:db-migrations',
  summary : 'run, manage db schema migrations in a meteor app',
  version : '0.0.1',
  documentation: 'README.md'
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
    'deps',
    'aldeed:collection2',
    'aldeed:simple-schema',
    'dburles:collection-helpers',
    'flvnt:logger@0.0.1',
    'flvnt:env@0.0.1',
    'flvnt:features@0.0.1',
    'flvnt:collection-schemas@0.0.1',
    'flvnt:api-utils@0.0.1',
    'tmeasday:publish-counts@0.4.0',
    'meteorhacks:subs-manager@1.3.0',
    'meteorhacks:unblock@1.1.0'
  ]);

  api.imply([
    'mongo',
    'aldeed:collection2',
    'aldeed:simple-schema',
    'dburles:collection-helpers',
    'flvnt:collection-schemas@0.0.1'
  ]);


  api.add_files([
    'lib/collections.coffee',
    'lib/migration.coffee',
  ], where);

  api.add_files([
  ], 'server');

  api.add_files([
  ], 'client');


  api.export('Migrations');
  api.export('Migration');

});


Package.on_test(function (api, where) {
  where = where || ['client'];

  // standard test helpers..
  api.use([
    'coffeescript', 'tinytest', 'test-helpers', 'coffeescript-test-helper',
    'fixtures'
  ]);


  // import the package..
  api.imply('flvnt:db-migrations', where, {bare: true});


  api.add_files([
    'tests/exports.coffee',
    'tests/methods.coffee'
  ], where);

});
