
Package.describe({
  name    : 'flvnt:app-layouts',
  summary : 'flvnt-web iron-router global layouts',
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
    'spacebars',
    'blaze',
    'ui',
    'session',
    'check',
    'tracker',
    'iron:router',
    'flvnt:iron-router@0.0.1',
    'flvnt:subs-manager@0.0.1',
    'meteorhacks:subs-manager@1.3.0',
    'flvnt:logger@0.0.1',
    'flvnt:api-utils@0.0.1',
    'flvnt:app-features@0.0.1',
    'flvnt:jquery-touch-events@0.0.1'
  ], where);

  api.add_files([
    'lib/client/global.jade',
    'lib/client/layouts.jade',
    'lib/client/loading.jade',
    'lib/client/not-found.jade'
  ], where);

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
    'stylus',
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
    'iron:router',
    'flvnt:iron-router@0.0.1',
    'flvnt:subs-manager@0.0.1',
    'meteorhacks:subs-manager@1.3.0',
    'flvnt:logger@0.0.1',
    'flvnt:api-utils@0.0.1',
    'flvnt:app-features@0.0.1',
    'flvnt:jquery-touch-events@0.0.1'
  ], where);


  // import the package..
  api.imply([
    'flvnt:app-layouts'
  ], where, {bare: true});


  api.add_files([
    'tests/exports.coffee',
    'tests/methods.coffee'
  ], where);

});
