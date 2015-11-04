
Package.describe({
  name    : 'flvnt:app-subs',
  summary : 'flvnt-web bridge to subscription manager packages (ccorcos:subs-cache, meteorhacks:subs-manager)',
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
    "aldeed:collection2@2.3.3",
    "aldeed:simple-schema@1.3.2",
    "ccorcos:subs-cache@0.0.5",
    "dburles:collection-helpers@1.0.3",
    "meteorhacks:unblock@1.1.0"
  ], ['client', 'server']);

  api.use([
    'iron:router',
    'flvnt:env@0.0.1',
    'flvnt:api-utils@0.0.1',
    'flvnt:app-features@0.0.1',
    'flvnt:logger@0.0.1'
  ]);


  api.add_files([
    'lib/client/app-subs.coffee'
  ], ['client']);


  api.export([
    'subs',
    'talent_subs',
    'notifications_subs',
    'notification_count_sub'
  ]);

});
