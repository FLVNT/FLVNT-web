
Package.describe({
  name    : 'flvnt:app-features',
  summary : 'flvnt:web feature toggles',
  version : '0.0.1',
  documentation : 'README.md'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['server', 'client'];

  api.use([
    'coffeescript',
    'underscore',
    'check',
    'flvnt:logger@0.0.1',
    'flvnt:env@0.0.1'
  ], where);


  api.add_files([
    'lib/features.coffee'
  ], where);


  api.export([
    'Features'
  ]);

});
