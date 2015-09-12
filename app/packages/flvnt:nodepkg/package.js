
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


  api.export('Util');
  api.export('Sys');
  api.export('Fs');
  api.export('Exec');
  api.export('Path');

});



Package.on_test(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['server'];

  // standard test helpers..
  api.use([
    'coffeescript', 'tinytest', 'test-helpers', 'coffeescript-test-helper'
  ]);


  // package specific..
  api.use([
  ], where);


  // import the package..
  api.imply('flvnt:nodepkg', where, {bare: true});


  api.add_files([
    'tests/exports.coffee',
    'tests/methods.coffee'
  ], where);

});
