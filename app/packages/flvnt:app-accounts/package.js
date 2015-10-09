
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
    'stylus',
    'mquandalle:jade@0.4.2',
    'underscore',
    'jquery',
    'templating',
    'blaze',
    'flvnt:event-hooks@0.0.1',
    'flvnt:env@0.0.1',
    'flvnt:logger@0.0.1',
    'flvnt:api-utils@0.0.1',
    'flvnt:app-features@0.0.1',
    'flvnt:collection-schemas@0.0.1',
    'aldeed:simple-schema@1.3.2',
    'aldeed:collection2@2.3.3',
    'dburles:collection-helpers@1.0.3',
    'mongo',
    'http',
    'tracker',
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
    'lib/app-accounts.coffee',
  ], where);


  api.add_files([
    'lib/config.coffee',
    'lib/startup.coffee',
    'lib/collections/meteor-users.coffee'
  ], where);

  api.add_files([
    'lib/server/app-accounts.coffee',
    'lib/server/config-api.coffee',
    'lib/server/hooks.coffee',
    'lib/server/publish/user-data.coffee'
  ], 'server');

  api.add_files([
    'lib/client/app-accounts.coffee',
    'lib/client/hooks.coffee',
    'lib/client/startup.coffee'
  ], 'client');


  api.export([
    'AppAccounts',
    'config'
  ], where);

  // api.export('load_accounts_services_config');

});
