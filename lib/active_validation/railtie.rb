if defined?(Rails)
  require 'rails'

  class ActiveValidation::Railtie < ::Rails::Railtie

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
