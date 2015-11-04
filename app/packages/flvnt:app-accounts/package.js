
Package.describe({
  name    : 'flvnt:app-accounts',
  summary : 'flvnt-web bridge to the meteor-accounts framework.',
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
    'accounts-ui-unstyled',
    'accounts-facebook',
    'accounts-google'
  ], ['client', 'server']);

  api.use([
    'aldeed:collection2@2.3.3',
    'aldeed:simple-schema@1.3.2',
    'dburles:collection-helpers@1.0.3',
    'meteorhacks:unblock@1.1.0',
    'ccorcos:subs-cache@0.0.5',
    'tmeasday:publish-counts@0.4.0'
  ], ['client', 'server']);

  api.use([
    'iron:router',
    // 'flvnt:app-iron-router@0.0.1',
    // 'flvnt:mixpanel@0.0.1',
    'flvnt:env@0.0.1',
    'flvnt:logger@0.0.1',
    'flvnt:api-utils@0.0.1',
    'flvnt:app-features@0.0.1',
    'flvnt:event-hooks@0.0.1',
    'flvnt:app-collection-schemas@0.0.1',
    'flvnt:google-sdk@0.0.1',
    'flvnt:facebook-sdk@0.0.1',
  ], ['client', 'server']);

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
    'lib/route-controller.coffee'
  ], ['client', 'server']);

  api.add_files([
    'lib/app-accounts.coffee',  // namespaces..
    'lib/accounts-ui-config.coffee',
    'lib/accounts-ui-config-scopes.coffee',
    'lib/collections/meteor-users-schema.coffee',
    'lib/startup.coffee'
  ], ['client', 'server']);

  api.add_files([
    'lib/server/app-accounts.coffee',
    'lib/server/config-api.coffee',
    'lib/server/methods/methods.coffee',
    'lib/server/hooks.coffee',
    'lib/server/publish/publish-user-data.coffee',
    'lib/server/startup.coffee'
  ], ['server']);

  api.add_files([
    'lib/client/service-connect-options.coffee',
    'lib/client/login/login-ui-handlers.coffee',
    'lib/client/init.coffee',
    'lib/client/hooks.coffee',
    'lib/client/startup.coffee',
    'lib/client/login/route.coffee',
    'lib/client/logout/route.coffee',
    'lib/client/logout/logout.jade'
  ], ['client']);


  // user profile..
  /*
  api.add_files([
  ], ['client']);
  */


  api.export([
    'AppAccounts',
    'PageTrackerController',
    // TODO: `AppSubscription` a good idea, but not fully implemented
    // 'AppSubscription',
  ]);

});
