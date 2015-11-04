
Package.describe({
  name    : 'flvnt:online',
  summary : "reactive variable for: `navigator.onLine` to react to the client's online/offline status",
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
    'flvnt:env@0.0.1',
    'flvnt:logger@0.0.1',
    'flvnt:api-utils@0.0.1',
    'flvnt:app-features@0.0.1'
  ], ['client', 'server']);


  api.addFiles([
    'lib/client/online.coffee'
  ], ['client']);

  api.addFiles([
    'lib/server/mongo-client.coffee'
  ], ['server']);


  api.export([
  ])

});
