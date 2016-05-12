require 'active_model'
require 'active_support'
require 'active_object'
require 'active_validation/version'

require 'active_validation/validators/alpha_validator'
require 'active_validation/validators/alpha_numeric_validator'
require 'active_validation/validators/base64_validator'
require 'active_validation/validators/boolean_validator'
require 'active_validation/validators/coordinate_validator'
require 'active_validation/validators/credit_card_validator'
require 'active_validation/validators/currency_validator'
require 'active_validation/validators/cusip_validator'
require 'active_validation/validators/email_validator'
require 'active_validation/validators/equality_validator'
require 'active_validation/validators/hex_validator'
require 'active_validation/validators/imei_validator'
require 'active_validation/validators/ip_validator'
require 'active_validation/validators/isbn_validator'
require 'active_validation/validators/isin_validator'
require 'active_validation/validators/mac_address_validator'
require 'active_validation/validators/name_validator'
require 'active_validation/validators/password_validator'
require 'active_validation/validators/phone_validator'
require 'active_validation/validators/sedol_validator'
require 'active_validation/validators/slug_validator'
require 'active_validation/validators/ssn_validator'
require 'active_validation/validators/tracking_number_validator'
require 'active_validation/validators/type_validator'
require 'active_validation/validators/url_validator'
require 'active_validation/validators/username_validator'
require 'active_validation/validators/uuid_validator'

if defined?(RSpec)
  require 'rspec/matchers'
  require 'active_validation/matchers/ensure_valid_alpha_format_of'
  require 'active_validation/matchers/ensure_valid_alpha_numeric_format_of'
  require 'active_validation/matchers/ensure_valid_base64_format_of'
  require 'active_validation/matchers/ensure_valid_boolean_format_of'
  require 'active_validation/matchers/ensure_valid_coordinate_format_of'
  require 'active_validation/matchers/ensure_valid_credit_card_format_of'
  require 'active_validation/matchers/ensure_valid_currency_format_of'
  require 'active_validation/matchers/ensure_valid_cusip_format_of'
  require 'active_validation/matchers/ensure_valid_email_format_of'
  require 'active_validation/matchers/ensure_valid_equality_matcher_of'
  require 'active_validation/matchers/ensure_valid_hex_format_of'
  require 'active_validation/matchers/ensure_valid_imei_format_of'
  require 'active_validation/matchers/ensure_valid_ip_format_of'
  require 'active_validation/matchers/ensure_valid_isbn_format_of'
  require 'active_validation/matchers/ensure_valid_isin_format_of'
  require 'active_validation/matchers/ensure_valid_mac_address_format_of'
  require 'active_validation/matchers/ensure_valid_name_format_of'
  require 'active_validation/matchers/ensure_valid_password_format_of'
  require 'active_validation/matchers/ensure_valid_phone_format_of'
  require 'active_validation/matchers/ensure_valid_sedol_format_of'
  require 'active_validation/matchers/ensure_valid_slug_format_of'
  require 'active_validation/matchers/ensure_valid_ssn_format_of'
  require 'active_validation/matchers/ensure_valid_tracking_number_format_of'
  require 'active_validation/matchers/ensure_valid_type_format_of'
  require 'active_validation/matchers/ensure_valid_url_format_of'
  require 'active_validation/matchers/ensure_valid_username_format_of'
  require 'active_validation/matchers/ensure_valid_uuid_format_of'
end

if defined?(Rails)
  require 'rails'

  module ActiveValidation
    class Railtie < ::Rails::Railtie

      initializer 'active_validation' do |app|
        ActiveValidation::Railtie.instance_eval do
          [app.config.i18n.available_locales].flatten.each do |locale|
            (I18n.load_path << path(locale)) if File.file?(path(locale))
          end
        end
      end

      protected

      def self.path(locale)
        File.expand_path("../../config/locales/#{locale}.yml", __FILE__)
      end

    end
  end
end
