
Package.describe({
  name    : 'flvnt:collection-schemas',
  summary : 'flvnt-web collections schema helpers package',
  version : '0.0.1',
  documentation : 'README.md'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['client', 'server'];


  api.use([
    'coffeescript',
    'underscore',
    'mongo',
    'flvnt:logger@0.0.1',
    'aldeed:simple-schema@1.3.2',
    'aldeed:collection2@2.3.3',
    'dburles:collection-helpers@1.0.3'
  ]);

  api.imply([
    'aldeed:simple-schema@1.3.2',
    'aldeed:collection2@2.3.3',
    'dburles:collection-helpers@1.0.3',
    'mongo'
  ]);

  api.add_files([
    'lib/schema-helpers.coffee',
    'lib/schema-helpers/timestamps.coffee'
  ], where);


  api.export('SchemaHelpers');

});


Package.on_test(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['client', 'server'];

  // standard test helpers..
  api.use([
    'coffeescript', 'tinytest', 'test-helpers', 'coffeescript-test-helper',
    'check',
    'flvnt:app-fixtures'
  ], where);


  // package specific..
  api.use([
    'underscore',
    'mongo',
    'flvnt:logger@0.0.1',
    'aldeed:simple-schema@1.3.2',
    'aldeed:collection2@2.3.3',
    'dburles:collection-helpers@1.0.3'
  ], where);


  // import the package..
  api.imply([
    'flvnt:collection-schemas'
  ], where, {bare: true});


  api.add_files([
    'tests/exports.coffee',
    'tests/methods.coffee'
  ], where);

});
