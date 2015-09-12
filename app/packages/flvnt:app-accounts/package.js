
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
    'underscore',
    'jquery',
    'mquandalle:jade',
    'templating',
    'ui',
    'blaze',
    'flvnt:env@0.0.1',
    'flvnt:logger@0.0.1',
    'flvnt:features@0.0.1',
    'flvnt:collection-schemas@0.0.1',
    'service-configuration',
    'aldeed:simple-schema@1.3.2',
    'aldeed:collection2@2.3.3',
    'dburles:collection-helpers@1.0.3',
    'mongo',
    'http',
    'deps',
    'oauth',
    'oauth2',
    'accounts-base',
    'accounts-password',
    'accounts-ui-unstyled@1.1.7',
    'accounts-facebook',
    'accounts-google',
    'soundcloud@0.0.1',

    // chrome bug: https://github.com/meteor/meteor/issues/1004#issuecomment-68652474
    // UA in Chrome iOS is same as Safari iOS, with CriOS/<ChromeRevision> addition
    'awatson1978:browser-detection@1.0.4'
  ], where);


  api.add_files([
    'lib/config.coffee',
    'lib/accounts.coffee'
  ], where);

  api.add_files([
    'lib/server/accounts.coffee'
  ], 'server');

  api.add_files([
    'lib/client/accounts.coffee'
  ], 'client');


  api.export('FLVNTAccounts', ['client', 'server']);
  api.export('config', ['client', 'server']);
  // api.export('load_accounts_services_config');

});


Package.on_test(function (api, where) {
  where = where || ['client'];

  // standard test helpers..
  api.use([
    'coffeescript', 'tinytest', 'test-helpers', 'coffeescript-test-helper',
    'fixtures'
  ]);


  // package specific..
  api.use([
    'ui',
    'blaze',
    'templating'
  ], where);


  // import the package..
  api.imply('flvnt:app-accounts', where, {bare: true});


  api.add_files([
    'tests/exports.coffee',
    'tests/methods.coffee'
  ], where);

});
