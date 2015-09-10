
Package.describe({
  name    : "meteor-winston-sentry",
  summary : "winston-sentry packaged for meteor.js",
  documentation: 'README.md'
});


Npm.depends({
  "winston": "0.7.2",
  "winston-sentry": "0.0.5"
});


Package.on_use(function(api) {

  api.use('coffeescript', 'server');
  api.add_files('winston-sentry.coffee', 'server');

  api.export('Winston');
  api.export('WinstonSentry');

});
