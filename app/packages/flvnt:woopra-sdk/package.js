
Package.describe({
  name    : 'flvnt:woopra-sdk',
  summary : 'woopra-sdk javascript loader package',
  version : '0.0.1',
  documentation : 'README.md'
});


Npm.depends({
  "woopra": "0.1.1"
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
    'spacebars',
    'ui',
    'mongo',
    'ddp',
    'http'
  ], ['client', 'server']);


  api.add_files([
    'lib/client/woopra-sdk.jade',
    'lib/client/woopra-sdk.js'
  ], ['client']);

  api.add_files([
    'lib/server/woopra-sdk.coffee'
  ], ['server']);


  api.export([
    'woopra',
    'Woopra'
  ]);

});
