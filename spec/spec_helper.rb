if ENV['ENABLE_CODE_COVERAGE']
  require 'simplecov'
  SimpleCov.start
end

require 'bundler/setup'
require 'active_campaign'
require 'webmock/rspec'

RSpec.configure do |config|
  config.before :suite do
    WebMock.disable_net_connect!
  end

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.run_all_when_everything_filtered = true
  config.filter_run :focus
end
