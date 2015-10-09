
Package.describe({
  name    : 'flvnt:env',
  summary : 'flvnt-web environment package',
  version : '0.0.1',
  documentation : 'README.md'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['server'];

  api.use([
    'coffeescript',
    'underscore',
    'json'
  ], ['client', 'server']);


  api.add_files([
    'lib/env-id.coffee'
  ], ['client', 'server']);

  api.add_files([
    'lib/env.coffee'
  ], where);


  api.export([
    'env_id',
    'env'
  ]);

});
