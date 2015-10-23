
Package.describe({
  name    : 'flvnt:logger',
  summary : 'flvnt-web logger packaged for meteor.js',
  version : '0.0.1',
  documentation : 'README.md'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['client', 'server'];

  api.use([
    'coffeescript',
    'underscore',
    'logging',
    'ejson',
    'flvnt:env@0.0.1'
  ], where);

  api.use([
    'meteor-winston-sentry'
  ], 'server');


  api.add_files([
    'lib/server/logger.coffee'
  ], 'server');

  api.add_files([
    'lib/client/logger.coffee'
  ], 'client');


  api.export('logger');

});
