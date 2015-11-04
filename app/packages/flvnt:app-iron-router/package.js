
Package.describe({
  name    : 'flvnt:app-iron-router',
  summary : 'flvnt-web bridge for the iron-router meteor.js package',
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
    'accounts-base',
    'service-configuration'
  ], ['client', 'server']);

  api.use([
    "aldeed:collection2@2.3.3",
    "aldeed:simple-schema@1.3.2",
    "dburles:collection-helpers@1.0.3",
    "meteorhacks:unblock@1.1.0",
    "ccorcos:subs-cache@0.0.5",
    "tmeasday:publish-counts@0.4.0"
  ], ['client', 'server']);

  api.use([
    'iron:router@1.0.7',
    // 'zimme:active-route@2.2.0',
    // 'zimme:iron-router-auth@3.1.0',
    'flvnt:env@0.0.1',
    'flvnt:logger@0.0.1',
    'flvnt:api-utils@0.0.1',
    'flvnt:app-features@0.0.1',
    'flvnt:app-collection-schemas@0.0.1'
  ], ['client', 'server']);

  api.use([
    'meteorhacks:fast-render@2.3.2'
  ], ['server']);

  api.use([
    // 'flvnt:jquery-touch-events@0.0.1'
    'flvnt:app-subs@0.0.1',
    'flvnt:app-handlebars@0.0.1',
    'flvnt:bootstrap@0.0.1',
    // chrome bug: https://github.com/meteor/meteor/issues/1004#issuecomment-68652474
    // UA in Chrome iOS is same as Safari iOS, with CriOS/<ChromeRevision> addition
    'awatson1978:browser-detection@1.0.4'
  ], ['client']);


  api.add_files([
    // 'lib/routes/html-head.jade',
    // 'lib/routes/route-loading.jade',
    // 'lib/routes/route-not-found.jade',
    'lib/router-config.coffee',
    'lib/router-goto.coffee'
  ], ['client', 'server']);

  // app specific routes..
  api.add_files([
    'lib/routes/server/unsubscribe-hook.coffee'
  ], ['server']);


  api.export([
    'AppSubscription'
  ]);

});
