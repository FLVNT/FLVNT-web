
Package.describe({
  name    : 'flvnt:event-hooks',
  summary : 'provides hooks for user-account events',
  version : '0.0.1',
  documentation : 'README.md'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['client', 'server'];

  api.use([
    'coffeescript',
    'underscore',
    'jquery',
    'session',
    'templating',
    'tracker',
    'blaze',
    'service-configuration',
    'oauth',
    'oauth2',
    'mongo',
    'http',
    'tracker',
    'mongo',
    'accounts-base',
    'oauth',
    'oauth2',
    'check',
    'service-configuration',
    'aldeed:collection2@2.3.3',
    'aldeed:simple-schema@1.3.2',
    'dburles:collection-helpers@1.0.3'
  ], where);


  api.add_files([
    'lib/client/event-hooks.js'
  ], 'client');

  api.add_files([
    'lib/server/event-hooks.coffee',
    'lib/server/user-observer.coffee',
    'lib/server/methods.coffee'
  ], 'server');

  api.add_files([
    'lib/collections/event-hooks.coffee'
  ], where);


  api.export([
    'Hooks',
    'EventHooksMonitoringCollection'
  ], where);

});
