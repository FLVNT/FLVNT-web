
Package.describe({
  name    : 'flvnt:app-subs-manager',
  summary : 'flvnt-web bridge to meteorhacks:subs-manager',
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
    'check',
    'session',
    'tracker',
    'iron:router',
    'flvnt:env@0.0.1',
    'flvnt:api-utils@0.0.1',
    'flvnt:app-features@0.0.1',
    'flvnt:logger@0.0.1',
    'meteorhacks:subs-manager@1.3.0'
  ]);


  api.add_files([
    'lib/client/subs-manager.coffee'
  ], where);


  api.export([
    'subs'
  ]);

});
