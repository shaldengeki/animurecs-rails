# Load the rails application
require File.expand_path('../application', __FILE__)

Animurecs::Application.configure do
  config.time_zone = "Central Time (US & Canada)"
end

# Initialize the rails application
Animurecs::Application.initialize!

