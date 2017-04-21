require 'bundler/setup'
require 'faker'
Dir['lib/**/*.rb'].each { |f| require f.gsub(%r{lib\/}, '') }
Dir['spec/helpers/**/*.rb'].each { |f| require f.gsub(%r{spec\/}, '') }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
