
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
    'flvnt:env@0.0.1',
    'flvnt:api-utils@0.0.1',
    'flvnt:app-features@0.0.1',
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


  api.export([
    'SchemaHelpers'
  ]);

});
