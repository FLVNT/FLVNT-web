
Package.describe({
  name    : 'flvnt:app-projects',
  summary : 'flvnt-web brand projects',
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
    'spacebars',
    'mongo',
    'ddp',
    'http'
  ], ['client', 'server']);

  api.use([
    'oauth',
    'oauth2',
    'accounts-base',
    'service-configuration'
  ], ['client', 'server']);

  api.use([
    "aldeed:collection2@2.3.3",
    "aldeed:simple-schema@1.3.2",
    "dburles:collection-helpers@1.0.3",
    "meteorhacks:unblock@1.1.0",
    "ccorcos:subs-cache@0.0.5",
    "tmeasday:publish-counts@0.4.0"
  ], ['client', 'server']);

  api.use([
    'iron:router',
    'flvnt:app-iron-router@0.0.1',
    'flvnt:env@0.0.1',
    'flvnt:api-utils@0.0.1',
    'flvnt:app-features@0.0.1',
    'flvnt:logger@0.0.1',
    "flvnt:event-hooks@0.0.1",
    'flvnt:app-collection-schemas@0.0.1',
    'flvnt:app-accounts@0.0.1'
  ], ['client', 'server']);

  api.use([
    // 'flvnt:jquery-touch-events@0.0.1'
    'flvnt:app-subs@0.0.1',
    'flvnt:app-handlebars@0.0.1',
    'flvnt:bootstrap@0.0.1',
    // chrome bug: https://github.com/meteor/meteor/issues/1004#issuecomment-68652474
    // UA in Chrome iOS is same as Safari iOS, with CriOS/<ChromeRevision> addition
    'awatson1978:browser-detection@1.0.4'
  ], ['client']);


  // COLLECTIONS
  // -----------
  api.add_files([
    'lib/collections/projects.coffee'
  ], ['client', 'server']);


  // CREATE
  // ------
  api.add_files([
    //
  ], ['client']);

  api.add_files([
    //
  ], ['server']);


  // EDIT
  // ------
  api.add_files([
    //
  ], ['client']);

  api.add_files([
    //
  ], ['server']);


  // PROFILE
  // -------
  api.add_files([
    //
  ], ['client']);

  api.add_files([
    //
  ], ['server']);


  api.export([
    'Projects'
  ]);

});
