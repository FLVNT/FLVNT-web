
Package.describe({
  name    : 'flvnt:event-hooks',
  summary : 'provides hooks for user-account events',
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
    'accounts-base',
    'accounts-password',
    // TODO: can we remove accounts-ui-unstyled .. ?
    'accounts-ui-unstyled'
  ], ['client', 'server']);

  api.use([
    'aldeed:collection2@2.3.3',
    'aldeed:simple-schema@1.3.2',
    'dburles:collection-helpers@1.0.3',
    'meteorhacks:unblock@1.1.0',
    'ccorcos:subs-cache@0.0.5'
  ], ['client', 'server']);


  api.add_files([
    'lib/collections/event-hooks.coffee'
  ], ['client', 'server']);

  api.add_files([
    'lib/server/event-hooks.coffee',
    'lib/server/user-observer.coffee',
    'lib/server/methods.coffee',
    'lib/server/hooks.js'
  ], ['server']);

  api.add_files([
    'lib/client/event-hooks.js'
  ], ['client']);


  api.export([
    'Hooks',
    'EventHooksMonitoringCollection'
  ]);
});
