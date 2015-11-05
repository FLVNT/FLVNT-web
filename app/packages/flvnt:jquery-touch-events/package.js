
// TODO: this package is a bit heavy (900 lines)..  is there something with as
// easy for usage without the bulk ?

Package.describe({
  name    : 'flvnt:jquery-touch-events',
  summary : 'jquery-touch-events packaged for meteor',
  version : '0.0.1',
  documentation : 'README.md'
});


Package.on_use(function (api) {
  api.versionsFrom('1.1.0.2');


  api.use([
    'coffeescript',
    'underscore',
    'jquery'
  ], ['client']);


  api.add_files([
    'lib/client/jquery-touch-events.js'
  ], ['client']);


  api.export([
  ]);
});
