
Package.describe({
  name    : 'flvnt:app-handlebars',
  summary : 'flvnt-web templating + UI helpers',
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
    'mongo',
    'ddp',
    'http'
  ], ['client', 'server']);

  api.use([
    // 'flvnt:app-facebook'
  ], ['client', 'server']);


  // template helpers..
  api.add_files([
    'lib/client/template/lock.coffee'
  ], ['client']);

  // form helpers..
  api.add_files([
    'lib/client/form/serialize.coffee'
  ], ['client']);

  // handlebars helpers..
  api.add_files([
    'lib/client/label-branch.coffee',
    'lib/client/datetime/u2gtime.coffee',
    // 'lib/client/each/each-modulo.coffee',
    'lib/client/each/each.coffee',
    'lib/client/image/user-thumb.coffee',
    'lib/client/string/lower.coffee',
    'lib/client/string/names.coffee',
    'lib/client/string/pluralize.coffee',
    'lib/client/string/reverse.coffee',
    'lib/client/string/truncate.coffee',
    'lib/client/url/absolute-url.coffee'
    // 'lib/client/user/user.coffee'
  ], ['client']);


  api.export([
    'abbreviate_name',
    'initial_name'
  ]);

});
