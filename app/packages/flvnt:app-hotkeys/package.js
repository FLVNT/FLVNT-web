
Package.describe({
  name    : 'flvnt:app-hotkeys',
  summary : 'flvnt-web hotkey bindings',
  version : '0.0.1',
  documentation : 'README.md'
});


Package.on_use(function (api, where) {
  // api.versionsFrom('1.1.0.2');
  where = where || ['client'];

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
    'lib/client/hotkeys.jade',
    'lib/client/hotkeys.coffee'
  ], where);


});


Package.on_test(function (api, where) {
  where = where || ['client', 'server'];

  // standard test helpers..
  api.use([
    'coffeescript', 'tinytest', 'test-helpers', 'coffeescript-test-helper',
    'fixtures', 'check'
  ], where);


  // package specific..
  api.use([
    'ui',
    'templating'
  ], ['client']);


  // import the package..
  api.imply('flvnt:app-hotkeys', where, {bare: true});


  api.add_files([
    'tests/exports.coffee',
    'tests/methods.coffee'
  ], where);

});
