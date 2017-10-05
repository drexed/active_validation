# frozen_string_literal: true

%w[action_dispatch active_model active_support].each do |file_name|
  require file_name
end

require 'active_support/core_ext/time/zones'
require 'active_validation/version'

ACTIVE_VALIDATION_VALIDATORS ||= %w[
  alpha alpha_numeric base64 boolean coordinate credit_card csv currency cusip email equality
  file_size hex imei ip isbn isin mac_address name password phone sedol slug ssn time_zone
  tracking_number type url username uuid
].freeze

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

      def self.path(locale)
        File.expand_path("../../config/locales/#{locale}.yml", __FILE__)
      end

    end
  end
end
