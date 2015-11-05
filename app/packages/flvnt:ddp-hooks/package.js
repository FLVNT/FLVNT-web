
Package.describe({
  name    : 'flvnt:ddp-hooks',
  summary : 'hooks for when a ddp-client connects/disconnects to a meteor app',
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
    'livedata',
    'mongo',
    'ddp',
    'http'
  ], ['client', 'server']);

  api.use([
    'flvnt:env@0.0.1',
    'flvnt:api-utils@0.0.1',
    'flvnt:app-features@0.0.1',
    'flvnt:logger@0.0.1'
  ], ['server']);


  api.add_files([
    'lib/server/ddp-hooks.coffee'
  ], ['server']);


  api.export([
    'DDP'
  ]);

});
