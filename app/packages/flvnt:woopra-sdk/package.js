
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
    'mquandalle:jade@0.4.2',
    'underscore',
    'jquery',
    'templating',
    'spacebars',
    'blaze',
    'ui',
    'session',
    'flvnt:logger@0.0.1',
    'flvnt:api-utils@0.0.1',
    'flvnt:lazyload@0.0.1',
    'flvnt:app-features@0.0.1'
  ], ['server', 'client']);

  api.use([
    'mquandalle:jade@0.4.2',
    'templating',
    'ui'
  ], where);

  api.add_files([
    'lib/client/woopra-sdk.jade',
    'lib/client/woopra-sdk.js'
  ], 'client');

  api.add_files([
    'lib/server/woopra-sdk.coffee'
  ], 'server');


  api.export('Woopra');

});
