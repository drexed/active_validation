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

      private_class_method :path

    end
  end
end
