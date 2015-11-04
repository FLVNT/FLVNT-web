
Package.describe({
  name    : 'flvnt:app-collection-schemas',
  summary : 'flvnt-web collections schema helpers package',
  version : '0.0.1',
  documentation : 'README.md'
});


Package.on_use(function (api) {
  api.versionsFrom('1.1.0.2');


  api.use([
    'coffeescript',
    'mquandalle:jade@0.4.2',
    'stylus',
    'underscore',
    'jquery',
    'tracker',
    'session',
    'check',
    'blaze',
    'templating',
    'mongo',
    'ddp',
    'http'
  ], ['client', 'server']);

  api.use([
    'oauth',
    'oauth2',
    'accounts-base',
    'service-configuration'
  ], ['client', 'server']);

  api.use([
    'aldeed:collection2@2.3.3',
    'aldeed:simple-schema@1.3.2',
    'dburles:collection-helpers@1.0.3',
    'meteorhacks:unblock@1.1.0',
    'ccorcos:subs-cache@0.0.5',
    'tmeasday:publish-counts@0.4.0'
  ], ['client', 'server']);

  api.use([
    'flvnt:env@0.0.1',
    'flvnt:api-utils@0.0.1',
    'flvnt:app-features@0.0.1',
    'flvnt:logger@0.0.1',
    "flvnt:event-hooks@0.0.1"
  ], ['client', 'server']);


  api.add_files([
    'lib/schema-helpers.coffee',
    'lib/schema-helpers/timestamps.coffee',
    'lib/schema-helpers/soft-delete.coffee'
  ], ['client', 'server']);


  api.export([
    'SchemaHelpers'
  ]);

});
