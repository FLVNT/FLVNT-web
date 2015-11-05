
Package.describe({
  name    : 'flvnt:env',
  summary : 'flvnt-web environment package',
  version : '0.0.1',
  documentation : 'README.md'
});


Package.on_use(function (api) {
  api.versionsFrom('1.1.0.2');


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
  ], ['server']);


  api.export([
    'env_id',
    'env'
  ]);

});
