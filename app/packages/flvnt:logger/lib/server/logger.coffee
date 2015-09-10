
transports = []

# send to the console
transports.push new Winston.transports.Console(
  colorize: true
  handleExceptions: true
  catchExceptions: false
)


if Meteor.settings.sentry_token? and Meteor.settings.sentry_token
  # send to sentry
  transports.push new WinstonSentry(
    level: 'warn'
    dsn: Meteor.settings.sentry_token
    patchGlobal: true
  )


### disable loggly
# send to loggly
if env_id isnt "test"

  transports.push new Winston.transports.Loggly(
    inputToken: "f5bb2e9b-b873-4c6d-b0f1-fd95d52c9460"
    subdomain: "unvael"
    json: true
    handleExceptions: true
    catchExceptions: false
    tags: ["meteor-app"]
    level: 'error'
  )
###


logger = new Winston.Logger(
  exitOnError: false
  transports: transports
)


### disable loggly
if env_id isnt "test" and logger.transports.loggly.client.config
  Object.defineProperty logger.transports.loggly.client.config, "inputUrl",
    value: "https://logs-01.loggly.com/inputs/"
    enumerable: true
    configurable: true
###
