# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)
run Rails.application

Giphy::Configuration.configure do |config|
  config.version = "v1"
  config.api_key = "dc6zaTOxFJmzC"
end
