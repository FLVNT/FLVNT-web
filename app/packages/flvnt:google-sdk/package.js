
Package.describe({
  name    : 'flvnt:google-sdk',
  summary : 'FLVNT-web meteor package + loader for the google javascript sdk',
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
    'service-configuration',
    'accounts-base',
    'oauth',
    'oauth2'
  ], ['client', 'server']);

  api.use([
    'aldeed:collection2@2.3.3',
    'aldeed:simple-schema@1.3.2',
    'dburles:collection-helpers@1.0.3',
    'meteorhacks:unblock@1.1.0',
    'ccorcos:subs-cache@0.0.5',
    "tmeasday:publish-counts@0.4.0"
  ], ['client', 'server']);

  api.use([
    'flvnt:env@0.0.1',
    'flvnt:logger@0.0.1',
    'flvnt:api-utils@0.0.1',
    'flvnt:app-features@0.0.1',
    'flvnt:app-collection-schemas@0.0.1'
  ], ['client', 'server']);

  api.use([
    // 'flvnt:jquery-touch-events@0.0.1'
    'flvnt:lazyload@0.0.1',
    'flvnt:app-handlebars@0.0.1',
    'flvnt:bootstrap@0.0.1',
    'flvnt:app-subs@0.0.1'
  ], ['client']);


  api.add_files([
    'lib/client/google-sdk.coffee'
  ], ['client', 'server']);


  api.export([
    'load_google_sdk'
  ]);

});
