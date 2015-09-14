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

Tinytest.add 'exports: app-fonts', (test) ->
  test.isFalse _.isUndefined Activity,
    "app-fonts should be exported in package: unvael:app-fonts"
