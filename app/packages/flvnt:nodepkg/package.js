
Package.describe({
  name    : 'flvnt:nodepkg',
  summary : 'flvnt-web generic node package wrapper',
  version : '0.0.1',
  documentation : 'README.md'
});


Npm.depends({
  util: "0.10.2"
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['server'];


  api.use([
    'coffeescript'
  ], where);


  api.add_files([
    'lib/server/nodepkg.coffee'
  ], where);


  api.export([
    'Util',
    'Sys',
    'Fs',
    'Exec',
    'Path'
  ]);

});
