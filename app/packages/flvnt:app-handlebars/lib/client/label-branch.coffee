
UI.registerHelper "labelBranch", (options) ->
  Spark.labelBranch Spark.UNIQUE_LABEL, =>
    options.fn @
