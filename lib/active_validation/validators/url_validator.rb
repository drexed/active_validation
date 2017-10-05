# frozen_string_literal: true

require 'uri'

class UrlValidator < ActiveModel::EachValidator

  DEFAULT_SCHEMES ||= %i[http https].freeze

  def validate_each(record, attribute, value)
    uri = URI.parse(value.to_s)
    raise URI::InvalidURIError unless valid?(uri, options)
  rescue URI::InvalidURIError
    record.errors[attribute] <<
      (options[:message] || I18n.t('active_validation.errors.messages.url'))
  end

  private

  def valid_domain?(value, options)
    value_downcased = value.host.to_s.downcase
    options.empty? || options.any? { |dom| value_downcased.end_with?(".#{dom.downcase}") }
  end

  def valid_length?(value)
    value.present?
  end

  def valid_scheme?(value, options)
    value_downcased = value.scheme.to_s.downcase
    options.empty? || options.any? { |sch| value_downcased == sch.to_s.downcase }
  end

  def valid_root?(value)
    ['/', ''].include?(value.path) && value.query.blank? && value.fragment.blank?
  end

  def valid_uri?(value)
    value.is_a?(URI::Generic)
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  def valid?(value, options)
    valid_length?(value) &&
      valid_uri?(value) &&
      valid_domain?(value, [*(options[:domain])]) &&
      valid_scheme?(value, [*(options[:scheme] || UrlValidator::DEFAULT_SCHEMES)]) &&
      (options[:root] ? valid_root?(value) : true)
  end
  # rubocop:enable Metrics/CyclomaticComplexity

end
