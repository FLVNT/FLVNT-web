###
TEST-API
--------

  test.equal actual, expected, message, not
  test.notEqual actual, expected, message
  test.instanceOf obj, klass
  test.matches actual, regexp, message
  test.isTrue actual, msg
  test.isFalse actual, msg
  test.isNull actual, msg
  test.isNotNull actual, msg
  test.isUndefined actual, msg
  test.isNaN actual, msg
  test.length obj, expected_length, msg

###

Tinytest.add 'exports: load_account_services_config', (test) ->
  test.isFalse _.isUndefined load_account_services_config,
    'load_account_services_config should be exported in package: flvnt:app-accounts'


Tinytest.add 'exports: add_service_connection (server)', (test) ->
  test.isFalse _.isUndefined Accounts.add_service_connection,
    'Accounts.add_service_connection should be exported in package: flvnt:app-accounts'


Tinytest.add 'exports: on_add_service_connection (server)', (test) ->
  test.isFalse _.isUndefined Accounts.on_add_service_connection,
    'Accounts.on_add_service_connection should be exported in package: flvnt:app-accounts'

