require "uri"
class UrlValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    uri = URI.parse(value.to_s)
    raise URI::InvalidURIError unless valid?(uri, options)
  rescue URI::InvalidURIError
    record.errors[attribute] << options.fetch(:message, I18n.t("active_validation.errors.messages.url"))
  end

  private

  DEFAULT_SCHEMES = [:http, :https]

  def valid_domain?(value, options)
    value_downcased = value.host.to_s.downcase
    options.empty? || options.any? { |d| value_downcased.end_with?(".#{d.downcase}") }
  end

  def valid_length?(value)
    value.present?
  end

  def valid_scheme?(value, options)
    value_downcased = value.scheme.to_s.downcase
    options.empty? || options.any? { |s| value_downcased == s.to_s.downcase }
  end

  def valid_root?(value)
    ["/", ""].include?(value.path) && value.query.blank? && value.fragment.blank?
  end

  def valid_uri?(value)
    value.kind_of?(URI::Generic)
  end

  def valid?(value, options)
    valid_length?(value) &&
    valid_uri?(value) &&
    valid_domain?(value, [*(options.fetch(:domain, nil))]) &&
    valid_scheme?(value, [*(options.fetch(:scheme, UrlValidator::DEFAULT_SCHEMES))]) &&
    (options.fetch(:root, false) ? valid_root?(value) : true)
  end

end
