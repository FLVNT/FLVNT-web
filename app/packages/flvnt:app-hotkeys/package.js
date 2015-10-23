
Package.describe({
  name    : 'flvnt:app-hotkeys',
  summary : 'flvnt-web hotkey bindings',
  version : '0.0.1',
  documentation : 'README.md'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['client'];

  api.use([
    'coffeescript',
    'stylus',
    'mquandalle:jade@0.4.2',
    'underscore',
    'jquery',
    'templating',
    'session',
    'check',
    'tracker',
    'iron:router@1.0.7',
    'flvnt:app-iron-router@0.0.1',
    'flvnt:app-subs-manager@0.0.1',
    'meteorhacks:subs-manager@1.3.0',
    'flvnt:logger@0.0.1',
    'flvnt:api-utils@0.0.1',
    'flvnt:app-features@0.0.1',
    'flvnt:bootstrap@0.0.1',
    // 'flvnt:jquery-touch-events@0.0.1',
    'flvnt:jquery-easing@0.0.1'
  ], where);


  api.add_files([
    'lib/client/hotkeys.jade',
    'lib/client/hotkeys.coffee'
  ], where);


  api.export([
  ]);

});
