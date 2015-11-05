
Package.describe({
  name    : 'flvnt:app-kadira',
  summary : 'flvnt-web kadira integration package',
  version : '0.0.1',
  documentation : 'README.md'
});


Package.on_use(function (api) {
  api.versionsFrom('1.1.0.2');


  api.use([
    'coffeescript',
    'underscore'
  ], ['server']);

  api.use([
    'meteorhacks:kadira',
    'meteorhacks:kadira-profiler',
    'meteorhacks:zones',
    'kadira:debug'
  ], ['server']);


  api.add_files([
    'server/lib/server.coffee'
  ], ['server']);


  api.export([
  ]);
});
