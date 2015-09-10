Package.describe({
  name    : 'event-hooks',
  summary : "Provides hooks for various user-triggered events",
  version : '0.0.1',
  documentation: 'README.md'
});

var both = ['client', 'server']

Package.on_use(function (api) {
  api.add_files(['client.js'], 'client');
  api.add_files(['server.js'], 'server');
  api.add_files(['common.js'], both);

  api.export(['Hooks', 'EventHooksMonitoringCollection'], both);
});
