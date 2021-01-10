require 'require_all'
require_all 'lib'

use Middlewares::KeyManager

map('/users') do
  run Application::Users.new
end

map('/rides') do
  run Application::Rides.new
end
