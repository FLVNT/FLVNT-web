
Package.describe({
  name    : 'flvnt:app-hotkeys',
  summary : 'flvnt-web hotkey bindings',
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
    'iron:router@1.0.7',
    'flvnt:env@0.0.1',
    'flvnt:app-iron-router@0.0.1',
    'flvnt:app-subs@0.0.1',
    'flvnt:logger@0.0.1',
    'flvnt:api-utils@0.0.1',
    'flvnt:app-features@0.0.1',
    'flvnt:bootstrap@0.0.1',
    "flvnt:event-hooks@0.0.1",
    'flvnt:app-collection-schemas@0.0.1'
  ], ['client']);


  api.add_files([
    'lib/client/hotkeys.jade',
    'lib/client/hotkeys.coffee'
  ], ['client']);


  api.export([
    'Hotkeys'
  ]);

});
