
Package.describe({
  name    : 'flvnt:app-iron-router',
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
    'jquery',
    'stylus',
    'underscore',
    'templating',
    'spacebars',
    'blaze',
    'session',
    'tracker',
    'check',
    'iron:router@1.0.7',
    // 'zimme:active-route@2.2.0',
    // 'zimme:iron-router-auth@3.1.0',
    'flvnt:env@0.0.1',
    'flvnt:logger@0.0.1',
    'flvnt:api-utils@0.0.1',
    'flvnt:app-features@0.0.1',
    // 'flvnt:app-handlebars@0.0.1',
    'flvnt:app-subs-manager@0.0.1'
  ], where);


  api.use([
    'meteorhacks:fast-render@2.3.2'
  ], ['server']);

  api.use([
    'flvnt:jquery-easing@0.0.1',
    'flvnt:bootstrap@0.0.1'
    // 'flvnt:device-js@0.0.1'
  ], ['client']);


  api.add_files([
    'lib/router-config.coffee',
    'lib/router-goto.coffee'
  ], where);

  // app specific routes..
  api.add_files([
    'lib/routes/server/unsubscribe-hook.coffee'
  ], ['server']);


  api.export([
  ]);

});
