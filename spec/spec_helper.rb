# frozen_string_literal: true

require 'action_dispatch'
require 'active_model'
require 'active_support'
require 'rspec/matchers'
require 'rspec/rails/extensions'
require 'shoulda'
require 'active_validation'

spec_matchers_path = Pathname.new(File.expand_path('../spec/matchers', File.dirname(__FILE__)))

I18n.load_path << File.expand_path('../../config/locales/en.yml', __FILE__)
I18n.enforce_available_locales = false

ACTIVE_VALIDATION_VALIDATORS.each do |file_name|
  require(spec_matchers_path.join("ensure_valid_#{file_name}_format_of.rb"))
end

RSpec.configure do |config|
  config.include Shoulda::Matchers::ActiveModel
  config.include Shoulda::Matchers::ActiveRecord
end
