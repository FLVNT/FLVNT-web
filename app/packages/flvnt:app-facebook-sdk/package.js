
Package.describe({
  name    : 'flvnt:app-facebook-sdk',
  summary : 'FLVNT-web meteor package for the facebook javascript sdk',
  version : '0.0.1',
  documentation : 'README.md'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['server', 'client'];


  api.use([
    'coffeescript',
    'underscore',
    'jquery',
    'stylus',
    'tracker',
    'session',
    'check',
    'blaze'
  ], ['client', 'server']);

  api.use([
    'service-configuration',
    'accounts-base',
    'oauth',
    'oauth2'
  ], ['client', 'server']);

  api.use([
    'http',
    'mongo',
    'aldeed:collection2@2.3.3',
    'aldeed:simple-schema@1.3.2',
    'dburles:collection-helpers@1.0.3',
    'meteorhacks:unblock@1.1.0',
    'meteorhacks:subs-manager@1.3.0',
    "flvnt:event-hooks@0.0.1",
    'flvnt:env@0.0.1',
    'flvnt:logger@0.0.1',
    'flvnt:app-features@0.0.1',
    'flvnt:api-utils@0.0.1',
    'flvnt:app-subs@0.0.1',
    'flvnt:app-collection-schemas@0.0.1'
    // 'flvnt:app-accounts@0.0.1'
  ], where);


  api.add_files([
    'lib/facebook.coffee',
    'lib/collections/collections.coffee'
  ], where);

  api.add_files([
    'lib/server/facebook.coffee',
    'lib/server/user-facebook.coffee',
    'lib/server/methods.coffee',
    'lib/server/publish.coffee'
  ], ['server']);

  api.add_files([
    'lib/client/facebook.coffee'
  ], ['client']);


  api.export([
    'FLVNT_FB',
    'FBFriends_2',
    'FBFriends',
    'FBFriendsByMusicLikes',
    'UserFacebook'
  ]);

});
