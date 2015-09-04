require 'sauce'
require 'rspec_junit'

require_relative 'sauce_helper'
require_relative 'spec_helpers'

# require all pages
base_dir ||= @original_dir ||= Dir.pwd
glob_path ||= File.join(base_dir, 'page', '**', '*.rb')
Dir.glob(glob_path) { |file| require_relative file }

RSpec.configure do |config|

  # sauce gem injects selenium instance at the before each rspec level
  # we can't use a singleton driver since the driver is created/destroyed
  # for every test
  config.before(:each) do
    @spec_helpers = SpecHelpers.new(@selenium)
  end

  config.after(:each) do
    @spec_helpers.driver_quit
  end
end
