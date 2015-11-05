
Package.describe({
  name    : 'flvnt:logger',
  summary : 'flvnt-web logger packaged for meteor.js',
  version : '0.0.1',
  documentation : 'README.md'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');


  api.use([
    'coffeescript',
    'underscore',
    'logging',
    'ejson',
    'json',
    'check',
    'livedata',
    'mongo',
    'ddp',
    'http'
  ], ['client', 'server']);

  api.use([
    'flvnt:env@0.0.1'
  ], ['client', 'server']);

  api.use([
    'jquery'
  ], ['client']);

  api.use([
    'meteor-winston-sentry'
  ], ['server']);


  api.add_files([
    'lib/server/logger.coffee'
  ], ['server']);

  api.add_files([
    'lib/client/logger.coffee'
  ], ['client']);


  api.export([
    'logger'
  ]);

});
