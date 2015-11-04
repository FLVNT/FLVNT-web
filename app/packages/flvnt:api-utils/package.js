
Package.describe({
  name    : 'flvnt:api-utils',
  summary : 'flvnt-web common methods used by the server Meteor.method() functions',
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
    'flvnt:logger@0.0.1'
  ], ['client', 'server']);


  api.add_files([
    'lib/server/api.coffee'
  ], 'server');

  api.add_files([
    'lib/client/api.coffee'
  ], 'client');


  api.export([
    'ApiUtils'
  ]);

});
