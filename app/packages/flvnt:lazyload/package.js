
// flvnt:lazyload: lazy-load javascript files on the client using <script>
// tag injection

Package.describe({
  name    : 'flvnt:lazyload',
  summary : 'javascript source loader on the client',
  version : '0.0.1',
  documentation : 'README.md'
});


Package.on_use(function (api) {
  api.versionsFrom('1.1.0.2');


  api.use([
    'coffeescript',
    'mquandalle:jade@0.4.2',
    'stylus',
    'underscore',
    'jquery',
    'tracker',
    'session',
    'check',
    'blaze',
    'templating',
    'livedata',
    'mongo',
    'ddp',
    'http'
  ], ['client', 'server']);

  api.use([
    'flvnt:env@0.0.1',
    'flvnt:app-features@0.0.1',
    'flvnt:api-utils@0.0.1',
    'flvnt:logger@0.0.1',
    'flvnt:online@0.0.1',
    // chrome bug: https://github.com/meteor/meteor/issues/1004#issuecomment-68652474
    // UA in Chrome iOS is same as Safari iOS, with CriOS/<ChromeRevision> addition
    'awatson1978:browser-detection@1.0.4'
  ], ['client']);


  api.add_files([
    'lib/client/lazyload.coffee'
  ], ['client']);


  api.export([
    'LazyLoad'
  ]);

});
