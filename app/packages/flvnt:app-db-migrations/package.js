
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
    'service-configuration',
    'accounts-base'
  ], ['client', 'server']);

  api.use([
    'aldeed:collection2@2.3.3',
    'aldeed:simple-schema@1.3.2',
    'dburles:collection-helpers@1.0.3',
    'meteorhacks:unblock@1.1.0'
    // 'tmeasday:publish-counts@0.4.0',
  ], ['server', 'client']);

  api.use([
    'flvnt:env@0.0.1',
    'flvnt:logger@0.0.1',
    'flvnt:api-utils@0.0.1',
    'flvnt:app-features@0.0.1',
    'flvnt:app-collection-schemas@0.0.1',
    'flvnt:app-subs@0.0.1'
  ], where);


  api.add_files([
    'lib/collections/collections.coffee'
  ], where);

  api.add_files([
    // 'lib/server/startup.coffee'
  ], 'server');

  api.add_files([
  ], 'client');


  api.export([
    'Migrations',
    'Migration'
  ]);

});
