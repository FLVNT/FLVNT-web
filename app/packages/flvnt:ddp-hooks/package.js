
Package.describe({
  name    : 'flvnt:ddp-hooks',
  summary : 'hooks for when a ddp-client connects/disconnects to a meteor app',
  version : '0.0.1',
  documentation : 'README.md'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['server'];


  api.use([
    'coffeescript',
    'underscore',
    'mongo',
    'ddp',
    'check',
    'tracker',
    'session',
    'flvnt:logger@0.0.1'
    // 'livedata'
  ], where);


  api.add_files([
    'lib/server/ddp-hooks.coffee'
  ], where);

});
