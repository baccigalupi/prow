def silence_warnings(&block)
  verbose_level = $VERBOSE
  debug_level = $DEBUG
  $VERBOSE = nil
  $DEBUG = nil

  result = block.call

  $VERBOSE = verbose_level
  $DEBUG = debug_level

  result
end
