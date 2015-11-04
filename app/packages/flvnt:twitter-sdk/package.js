
Package.describe({
  name    : 'flvnt:twitter-sdk',
  summary : 'FLVNT-web meteor package for the twitter javascript sdk',
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
    'service-configuration',
    'accounts-base'
  ], ['client', 'server']);

  api.use([
    'flvnt:env@0.0.1',
    'flvnt:logger@0.0.1',
    'flvnt:api-utils@0.0.1',
    'flvnt:app-features@0.0.1',
    'aldeed:simple-schema@1.3.2',
    'aldeed:collection2@2.3.3',
    'dburles:collection-helpers@1.0.3',
    'flvnt:app-subs@0.0.1',
    'flvnt:app-collection-schemas@0.0.1'
  ], ['client', 'server']);


  api.add_files([
  ], ['client', 'server']);


  api.export([
  ]);
});
