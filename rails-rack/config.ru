# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'
require_relative 'lib/status_checker'

map('/status') do
  run StatusCheckerApplication.new
end

run Rails.application
Rails.application.load_server
