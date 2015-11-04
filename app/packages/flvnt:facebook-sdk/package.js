
Package.describe({
  name    : 'flvnt:facebook-sdk',
  summary : 'facebook-sdk javascript loader',
  version : '0.0.1',
  documentation : 'README.md'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['client'];


  api.use([
    'coffeescript',
    'underscore',
    'jquery',
    'flvnt:lazyload@0.0.1',
    'flvnt:logger@0.0.1'
  ], where);


  api.add_files([
    'lib/client/facebook-sdk.coffee'
  ], where);


  api.export([
    'load_facebook_sdk'
  ]);

});
