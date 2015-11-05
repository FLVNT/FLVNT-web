
_transports = []


#: sends to the console
_transports.push new Winston.transports.Console
  colorize: true
  handleExceptions: true
  catchExceptions: false


if Meteor.settings.sentry_token?.length
  #s sends to sentry
  _transports.push new WinstonSentry
    dsn         : Meteor.settings.sentry_token
    level       : 'warn'
    patchGlobal : true


### sends to loggly (DISABLED)
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


logger = new Winston.Logger
  exitOnError: false
  transports: _transports


# LOGGER PROPERTIES:
# logger.sentry_client
# - instance of a sentry-raven Client() class
# - methods exposed:
#   - sentry_client.captureMessage(msg, kwargs, db)
#   - sentry_client.captureError(err, kwargs, cb)
#   - sentry_client.captureQuery(query, engine, kwargs, cb)


### sends to loggly (DISABLED)
if env_id isnt "test" and logger.transports.loggly.client.config
  Object.defineProperty logger.transports.loggly.client.config, "inputUrl",
    value: "https://logs-01.loggly.com/inputs/"
    enumerable: true
    configurable: true
###
