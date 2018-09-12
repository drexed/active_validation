# frozen_string_literal: true

class EmailValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    return if valid?(value.to_s, options)

    record.errors[attribute] <<
      (options[:message] || I18n.t('active_validation.errors.messages.email'))
  end

  private

  def valid_domain?(value, options)
    options.empty? || options.any? { |dom| value.downcase.end_with?(".#{dom.downcase}") }
  end

  def valid_format?(value)
    value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  end

  def valid_length?(value)
    value.present?
  end

  def valid?(value, options)
    options = [*(options[:domain])]

    valid_length?(value) &&
      valid_format?(value) &&
      valid_domain?(value, options)
  end

end
