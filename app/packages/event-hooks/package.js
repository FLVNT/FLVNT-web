
Package.describe({
  name    : 'event-hooks',
  summary : "Provides hooks for various user-triggered events",
  version : '0.0.1',
  documentation: 'README.md'
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['client', 'server'];

  api.add_files(['lib/client/event-hooks.js'], 'client');
  api.add_files(['lib/server/event-hooks.js'], 'server');
  api.add_files(['lib/event-hooks.js'], where);

  api.export(['Hooks', 'EventHooksMonitoringCollection'], where);

});
