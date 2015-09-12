
// flvnt:lazyload: lazy-load javascript files on the client using <script>
// tag injection

Package.describe({
  name    : 'flvnt:lazyload',
  summary : 'javascript source loader on the client',
  version : '0.0.1',
  documentation: 'README.md'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['client'];

  api.use([
    'underscore',
    'jquery',
    'blaze',
    'templating',
    'session',
    'coffeescript',
    'flvnt:logger@0.0.1'
  ], where);

  api.add_files([
    'client/lib/lazyload.coffee'
  ], where);

  api.export('LazyLoad');
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
  api.imply('flvnt:lazyload', where, {bare: true});


  api.add_files([
    'tests/exports.coffee',
    'tests/methods.coffee'
  ], where);

});