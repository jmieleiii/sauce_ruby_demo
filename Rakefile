require 'bundler/setup'
require 'sauce'
require 'fileutils'

# rake sauce:spec[files,concurrency,test_options,parallel_options]      # Run specs in parallel on Sauce Labs

# ensure junit folder exists (used by sauce:spec parallel runs)
# junit folder is defined in .rspec_parallel
junit = 'junit'

# clean out old junit results
FileUtils.rm_rf junit
Dir.mkdir junit
