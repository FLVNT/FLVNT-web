
Package.describe({
  name    : 'flvnt:nodepkg',
  summary : 'generic node package wrapper',
  version : '0.0.1',
  documentation: 'README.md'
});


Npm.depends({
  util: "0.10.2"
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.0');
  where = where || ['server'];

  api.add_files([
    'main.js'
  ], where);

  api.export('Util');
  api.export('Sys');
  api.export('Fs');
  api.export('Exec');
  api.export('Path');

});


Package.on_test(function (api, where) {
  where = where || ['client'];

  // standard test helpers..
  api.use([
    'coffeescript', 'tinytest', 'test-helpers', 'coffeescript-test-helper',
    'fixtures'
  ]);


  // package specific..
  api.use([
    'ui',
    'templating'
  ], where);


  // import the package..
  api.imply('unvael:nodepkg', where, {bare: true});


  api.add_files([
    'tests/exports.coffee',
    'tests/methods.coffee'
  ], where);

});
