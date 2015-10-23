
Package.describe({
  name    : 'flvnt:app-accounts',
  summary : 'flvnt-web bridge to the meteor-accounts framework.',
  version : '0.0.1',
  documentation : 'README.md'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['client', 'server'];


  api.use([
    'coffeescript',
    'mquandalle:jade@0.4.2',
    'stylus',
    'underscore',
    'jquery',
    'templating',
    'blaze',
    'session',
    'tracker',
    'flvnt:event-hooks@0.0.1',
    'flvnt:env@0.0.1',
    'flvnt:logger@0.0.1',
    'flvnt:api-utils@0.0.1',
    'flvnt:app-features@0.0.1',
    'flvnt:app-facebook@0.0.1',
    'flvnt:collection-schemas@0.0.1',
    'aldeed:simple-schema@1.3.2',
    'aldeed:collection2@2.3.3',
    'dburles:collection-helpers@1.0.3',
    'iron:router',
    // 'flvnt:app-iron-router@0.0.1',
    // 'flvnt:mixpanel@0.0.1',
    'mongo',
    'http',
    'check',
    'oauth',
    'oauth2',
    'service-configuration',
    'accounts-base',
    'accounts-password',
    'accounts-ui-unstyled',
    'accounts-facebook',
    'accounts-google',
    'flvnt:google-sdk@0.0.1',
    'flvnt:facebook-sdk@0.0.1',

    // chrome bug: https://github.com/meteor/meteor/issues/1004#issuecomment-68652474
    // UA in Chrome iOS is same as Safari iOS, with CriOS/<ChromeRevision> addition
    'awatson1978:browser-detection@1.0.4'
  ], where);


  api.add_files([
    'lib/route-controller.coffee'
  ], where);

  api.add_files([
    'lib/app-accounts.coffee',
    'lib/config.coffee',
    'lib/collections/meteor-users-schema.coffee',
    'lib/startup.coffee'
  ], where);

  api.add_files([
    'lib/server/app-accounts.coffee',
    'lib/server/config-api.coffee',
    'lib/server/methods/methods.coffee',
    'lib/server/hooks.coffee',
    'lib/server/publish/publish-user-data.coffee',
    'lib/server/startup.coffee'
  ], ['server']);

  api.add_files([
    'lib/client/app-accounts.coffee',
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
    'config'
  ], where);

});
