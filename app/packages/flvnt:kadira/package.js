
Package.describe({
  name    : 'flvnt:kadira',
  summary : 'flvnt-web kadira integration package',
  version : '0.0.1',
  documentation : 'README.md'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['server'];

  api.use([
    'coffeescript',
    'underscore',
    'meteorhacks:kadira',
    'meteorhacks:kadira-profiler',
    'meteorhacks:zones',
    'kadira:debug'
  ], where);

  api.add_files([
    'server/lib/server.coffee'
  ], where);

});


Package.on_test(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['server'];

  // standard test helpers..
  api.use([
    'coffeescript', 'tinytest', 'test-helpers', 'coffeescript-test-helper',
    'check',
    'flvnt:app-fixtures'
  ], where);

  // package specific..
  api.use([
    'underscore',
    'jquery',
    'ui',
    'blaze',
    'templating',
    'session'
  ], where);

  // import the package..
  api.imply([
    'flvnt:kadira'
  ], where, {bare: true});

  api.add_files([
    'tests/exports.coffee',
    'tests/methods.coffee'
  ], where);

});
