
Package.describe({
  name    : 'flvnt:app-beta-invites',
  summary : 'flvnt-web app beta invites for meteor.js',
  version : '0.0.1',
  documentation : 'README.md'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['client', 'server'];


  api.use([
    'coffeescript',
    'mquandalle:jade@0.4.2',
    'stylus',
    'underscore',
    'jquery',
    'templating',
    'tracker',
    'session',
    'check',
    'iron:router',
    'flvnt:env@0.0.1',
    'flvnt:logger@0.0.1',
    'flvnt:app-features@0.0.1',
    'flvnt:app-accounts@0.0.1',
    'flvnt:app-handlebars@0.0.1',
    'flvnt:app-iron-router@0.0.1',
    'flvnt:api-utils@0.0.1',
    'flvnt:app-iron-router@0.0.1',
    'flvnt:mixpanel@0.0.1',
    'aldeed:collection2@2.3.3',
    'aldeed:simple-schema@1.3.2',
    'dburles:collection-helpers@1.0.3',
    'meteorhacks:unblock@1.1.0',
    'meteorhacks:subs-manager@1.3.0',
    "flvnt:event-hooks@0.0.1",
    'flvnt:collection-schemas@0.0.1'
  ], where);


  api.add_files([
    'lib/collections/invite-queues.coffee',
    'lib/collections/group-invites.coffee',
    'lib/collections/invite-codes.coffee',
    'lib/collections/invite-signups.coffee'
  ], where);

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
