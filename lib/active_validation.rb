require 'active_model'
require 'active_support'

%w(version)
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
