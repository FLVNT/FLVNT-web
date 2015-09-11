
Package.describe({
  name    : 'flvnt:handlebars',
  summary : 'flvnt-web templating + UI helpers',
  version : '0.0.1',
  documentation: 'README.md'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['client'];

  api.use([
    'coffeescript',
    'underscore',
    'jquery',
    'templating',
    'ui',
    'session',
    'check',
  ], ['client', 'server']);

  api.use([
    'ui', 'spacebars', 'blaze', 'templating'
  ], where);

  api.add_files([
    'lib/client/label-branch.coffee',
    'lib/client/datetime/u2gtime.coffee',
    'lib/client/each/each-modulo.coffee',
    'lib/client/each/each.coffee',
    'lib/client/image/user-thumb.coffee',
    'lib/client/string/lower.coffee',
    'lib/client/string/names.coffee',
    'lib/client/string/pluralize.coffee',
    'lib/client/string/reverse.coffee',
    'lib/client/string/truncate.coffee',
    'lib/client/url/absolute-url.coffee'
  ], where);

  api.export('abbreviate_name');
  api.export('initial_name');

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
  api.imply('flvnt:handlebars', where, {bare: true});


  api.add_files([
    'tests/exports.coffee',
    'tests/methods.coffee'
  ], where);

});
