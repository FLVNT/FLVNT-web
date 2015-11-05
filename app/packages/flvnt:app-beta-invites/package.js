
Package.describe({
  name    : 'flvnt:app-beta-invites',
  summary : 'flvnt-web app beta invites for meteor.js',
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
    'aldeed:collection2@2.3.3',
    'aldeed:simple-schema@1.3.2',
    'dburles:collection-helpers@1.0.3',
    'meteorhacks:unblock@1.1.0',
    'ccorcos:subs-cache@0.0.5',
    'tmeasday:publish-counts@0.4.0'
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


  api.add_files([
    'lib/collections/invite-queues.coffee',
    'lib/collections/group-invites.coffee',
    'lib/collections/invite-codes.coffee',
    'lib/collections/invite-signups.coffee'
  ], ['client', 'server']);

  api.add_files([
    'lib/server/group-invites-api.coffee',
    'lib/server/methods/methods.coffee',
    'lib/server/publish/publish.coffee'
  ], ['server']);

  api.add_files([
    'lib/client/accept/accept-api.coffee',
    'lib/client/accept/templates/accept.jade',
    'lib/client/accept/templates/accept.coffee',
    'lib/client/accept/routes/routes.coffee',
    'lib/client/signup-complete/signup-complete-api.coffee',
    'lib/client/signup-complete/templates/signup-complete.jade',
    'lib/client/signup-complete/templates/signup-complete.coffee',
    'lib/client/signup-complete/routes/routes.coffee',
    'lib/client/subscribe/subscribe.coffee'
  ], ['client']);


  api.export([
    'InviteCodes',
    'InviteSignups',
    'InviteQueues',
    'GroupInvites',
    'GroupInviteAPI',
    'AccountSetup',
    'InviteAccept'
  ]);

});
