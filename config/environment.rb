# Load the rails application
require File.expand_path('../application', __FILE__)

ActiveSupport::Inflector.inflections do |inflect|
    inflect.irregular 'serial', 'series'
end

# Initialize the rails application
Animurecs::Application.initialize!

