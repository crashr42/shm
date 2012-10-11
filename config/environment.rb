# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Shm::Application.initialize!

Date::DATE_FORMATS[:ru] = "%d.%m.%Y"