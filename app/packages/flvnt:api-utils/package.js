
Package.describe({
  name    : 'flvnt:api-utils',
  summary : 'flvnt-web common methods used by the server Meteor.method() functions',
  version : '0.0.1',
  documentation : 'README.md'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['client', 'server'];


  api.use([
    'coffeescript',
    'underscore',
    'check',
    'flvnt:logger@0.0.1'
  ], where);


  api.add_files([
    'lib/server/api.coffee'
  ], 'server');

  api.add_files([
    'lib/client/api.coffee'
  ], 'client');


  api.export([
    'ApiUtils'
  ]);

});
