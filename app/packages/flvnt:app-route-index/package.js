
Package.describe({
  name    : 'flvnt:app-routes-index',
  summary : 'flvnt-web route: index /',
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
    'flvnt:env@0.0.1',
    'flvnt:logger@0.0.1',
    'flvnt:api-utils@0.0.1',
    'flvnt:app-features@0.0.1',
    'flvnt:bootstrap@0.0.1',
    'flvnt:jquery-touch-events@0.0.1'
  ], where);


  api.add_files([
    'lib/client/route.coffee',
    'lib/client/templates/route-index.jade',
    'lib/client/templates/route-index.coffee'
  ], ['client']);

});
