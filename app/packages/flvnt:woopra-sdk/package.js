
Package.describe({
  name    : 'flvnt:woopra-sdk',
  summary : 'woopra-sdk javascript loader package',
  version : '0.0.1',
  documentation : 'README.md'
});


Npm.depends({
  "woopra": "0.1.1"
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || 'client';

  api.use([
    'coffeescript',
    'mquandalle:jade@0.4.2',
    'underscore',
    'jquery',
    'templating',
    'spacebars',
    'blaze',
    'ui',
    'session',
    'flvnt:logger@0.0.1',
    'flvnt:api-utils@0.0.1',
    'flvnt:lazyload@0.0.1',
    'flvnt:app-features@0.0.1'
  ], ['server', 'client']);


  api.use([
    'mquandalle:jade@0.4.2',
    'jquery',
    'templating',
    'blaze',
    'ui'
  ], where);


  api.add_files([
    'lib/client/woopra-sdk.jade',
    'lib/client/woopra-sdk.js'
  ], 'client');

  api.add_files([
    'lib/server/woopra-sdk.coffee'
  ], 'server');


  api.export('woopra', where);
  api.export('Woopra', where);

});


Package.on_test(function (api, where) {
  where = where || ['client'];

  // standard test helpers..
  api.use([
    'coffeescript', 'tinytest', 'test-helpers', 'coffeescript-test-helper',
    'flvnt:app-fixtures'
  ]);


  // package specific..
  api.use([
    'ui',
    'templating'
  ], where);


  // import the package..
  api.imply([
    'flvnt:woopra-sdk'
  ], where, {bare: true});


  api.add_files([
    'tests/exports.coffee',
    'tests/methods.coffee'
  ], where);

});
