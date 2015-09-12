
Package.describe({
  name    : 'flvnt:woopra-sdk',
  summary : 'woopra-sdk javascript loader package',
  version : '0.0.1',
  documentation : 'README.md'
});


Npm.depends({
  "woopra": "0.1.1"
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || 'client';

  api.use([
    'coffeescript',
    'underscore',
    'flvnt:logger@0.0.1'
  ], ['server', 'client']);

  api.use([
    'mquandalle:jade@0.4.2',
    'templating',
    'ui'
  ], where);

  api.add_files([
    'lib/woopra.jade',
    'lib/woopra-client.js'
  ], where);

  api.add_files('lib/woopra-server.coffee', 'server');


  api.export('Woopra');

});
