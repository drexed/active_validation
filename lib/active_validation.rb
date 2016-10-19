require 'active_model'
require 'active_support'

%w(version railtie)
  .each do |file_name|
    require "active_validation/#{file_name}"
  end

ACTIVE_VALIDATION_VALIDATORS ||= %w(
  alpha alpha_numeric base64 boolean coordinate credit_card currency cusip email equality hex imei
  ip isbn isin mac_address name password phone sedol slug ssn tracking_number type url username uuid
)

ACTIVE_VALIDATION_VALIDATORS.each do |file_name|
  require "active_validation/validators/#{file_name}_validator"
end
