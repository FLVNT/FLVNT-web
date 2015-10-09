
Package.describe({
  name    : 'flvnt:app-users',
  summary : 'flvnt-web app-users global layouts',
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
    'session',
    'check',
    'tracker',
    'iron:router',
    'meteorhacks:subs-manager@1.3.0',
    'flvnt:env@0.0.1',
    'flvnt:api-utils@0.0.1',
    'flvnt:app-features@0.0.1',
    'flvnt:logger@0.0.1',
    'flvnt:app-iron-router@0.0.1',
    'flvnt:app-subs-manager@0.0.1',
    // 'flvnt:jquery-touch-events@0.0.1',
    'flvnt:app-accounts@0.0.1'
  ], where);


  api.add_files([
    'lib/collections/brands.coffee',
    'lib/collections/influencers.coffee',
    'lib/schemas/brands.coffee',
    'lib/schemas/influencers.coffee'
  ], where);


  api.export([
  ]);

});
