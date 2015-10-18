class EmailValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless valid?(value.to_s, options)
      record.errors[attribute] << (options.fetch(:message, false) || I18n.t('active_validation.errors.messages.email'.freeze))
    end
  end

  private

  def valid_domain?(value, options)
    options.empty? || options.any? { |d| value.downcase.end_with?(".#{d.downcase}") }
  end

  def valid_format?(value)
    value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  end

  def valid_length?(value)
    value.present?
  end

  def valid?(value, options)
    valid_length?(value) &&
    valid_format?(value) &&
    valid_domain?(value, [*(options.fetch(:domain, nil))])
  end

end