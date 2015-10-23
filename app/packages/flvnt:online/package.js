
Package.describe({
  name    : 'flvnt:online',
  summary : "reactive variable for: `navigator.onLine` to react to the client's online/offline status",
  version : '0.0.1',
  documentation : 'README.md'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['client'];


  api.use([
    'coffeescript',
    'mquandalle:jade@0.4.2',
    'stylus',
    'underscore',
    'jquery',
    'templating',
    'session',
    'tracker',
    'http',
    'mongo',
    'livedata',
    'check',
    'flvnt:env@0.0.1',
    'flvnt:logger@0.0.1',
    'flvnt:api-utils@0.0.1',
    'flvnt:app-features@0.0.1'
  ], ['client', 'server']);


  api.addFiles([
    'lib/client/online.coffee'
  ], where);

  api.addFiles([
    'lib/server/mongo-client.coffee'
  ], ['server']);

});
