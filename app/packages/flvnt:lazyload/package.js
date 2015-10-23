
// flvnt:lazyload: lazy-load javascript files on the client using <script>
// tag injection

Package.describe({
  name    : 'flvnt:lazyload',
  summary : 'javascript source loader on the client',
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
    'blaze',
    'templating',
    'session',
    'tracker',
    'check',
    'flvnt:env@0.0.1',
    'flvnt:app-features@0.0.1',
    'flvnt:api-utils@0.0.1',
    'flvnt:logger@0.0.1',
    'flvnt:online@0.0.1'
  ], where);


  api.add_files([
    'lib/client/lazyload.coffee'
  ], where);


  api.export([
    'LazyLoad'
  ]);

});
