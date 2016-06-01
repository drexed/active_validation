require "coveralls"
Coveralls.wear!

require "active_model"
require "active_support"
require "shoulda"
require "active_validation"

I18n.load_path << File.expand_path("../../config/locales/en.yml", __FILE__)
I18n.enforce_available_locales = false
