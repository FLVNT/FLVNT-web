
Package.describe({
  name: 'node-btoa',
  summary: 'node-btoa packaged for meteor',
  version: '0.0.1',
  documentation: 'README.md'
});


Npm.depends({
  "btoa": "1.1.1"
});


Package.on_use(function (api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['server'];

  api.use('coffeescript', where);

  api.add_files('lib/server/node-btoa.coffee', where);

  api.export('btoa');

});
