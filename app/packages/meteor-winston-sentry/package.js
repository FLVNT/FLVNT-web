
Package.describe({
  name    : "meteor-winston-sentry",
  summary : "winston-sentry packaged for meteor.js",
  documentation : 'README.md'
});


Npm.depends({
  "winston": "0.7.2",
  "winston-sentry": "0.0.5"
});


Package.on_use(function(api, where) {
  api.versionsFrom('1.1.0.2');
  where = where || ['server'];


  api.use([
    'coffeescript'
  ], where);


  api.add_files([
    'lib/winston-sentry.coffee'
  ], where);


  api.export('Winston');
  api.export('WinstonSentry');

});
