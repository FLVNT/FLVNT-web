
Package.describe({
  name    : 'flvnt:iron-router',
  summary : 'flvnt-web bridge for the iron-router meteor.js package',
  version : '0.0.1',
  documentation : 'README.md'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['client', 'server'];


  api.use([
    'coffeescript',
    'mquandalle:jade@0.4.2',
    'underscore',
    'jquery',
    'templating',
    'spacebars',
    'blaze',
    'ui',
    'session',
    'check',
    'tracker',
    'iron:router@1.0.7',
    'zimme:active-route@2.2.0',
    'zimme:iron-router-auth@3.1.0',
    'meteorhacks:fast-render@2.3.2',
    'flvnt:subs-manager@0.0.1',
    'flvnt:logger@0.0.1',
    'flvnt:api-utils@0.0.1',
    'flvnt:app-features@0.0.1'
  ], ['client', 'server']);


  api.add_files([
    'lib/client/router-goto.coffee'
  ], where);

  api.add_files([
    'lib/client/router-config.coffee'
  ], 'client');


  // app-default routes..
  api.add_files([
    'lib/routes/server/unsubscribe-hook.coffee'
  ], 'server');


});


Package.on_test(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['client', 'server'];

  // standard test helpers..
  api.use([
    'coffeescript', 'tinytest', 'test-helpers', 'coffeescript-test-helper',
    'check',
    'flvnt:app-fixtures'
  ], where);


  // package specific..
  api.use([
    'underscore',
    'jquery',
    'ui',
    'blaze',
    'templating',
    'session',
    'tracker',
    'iron:router@1.0.7',
    'zimme:active-route@2.2.0',
    'zimme:iron-router-auth@3.1.0',
    'meteorhacks:fast-render@2.3.2',
    'flvnt:subs-manager@0.0.1',
    'flvnt:logger@0.0.1',
    'flvnt:api-utils@0.0.1',
    'flvnt:app-features@0.0.1'
  ], where);


  // import the package..
  api.imply([
    'flvnt:iron-router'
  ], where, {bare: true});


  api.add_files([
    'tests/exports.coffee',
    'tests/methods.coffee'
  ], where);

});
