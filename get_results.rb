require File.expand_path('../boot', __FILE__)

reporter = Reporter.new(ARGV[0])
puts reporter.all
