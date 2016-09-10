require 'coveralls'
Coveralls.wear!

require 'active_model'
require 'active_support'
require 'rspec/matchers'
require 'shoulda'
require 'active_validation'

spec_matchers_path = Pathname.new(File.expand_path('../spec/matchers', File.dirname(__FILE__)))

I18n.load_path << File.expand_path('../../config/locales/en.yml', __FILE__)
I18n.enforce_available_locales = false

%w(
    alpha alpha_numeric base64 boolean coordinate credit_card currency cusip email equality hex imei
    ip isbn isin mac_address name password phone sedol slug ssn tracking_number type url username
    uuid
  )
  .each do |file_name|
    require(spec_matchers_path.join("ensure_valid_#{file_name}_format_of.rb"))
  end
