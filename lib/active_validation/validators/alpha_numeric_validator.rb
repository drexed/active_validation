# frozen_string_literal: true

class AlphaNumericValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    return if valid?(value.to_s, options)

    record.errors[attribute] <<
      (options[:message] || I18n.t('active_validation.errors.messages.alpha_numeric'))
  end

  private

  def valid_format?(value, options)
    strict = options[:strict]

    value =~ case options[:case]
             when :lower
               strict ? /^[a-z0-9]+$/ : /^[a-z0-9 ]+$/
             when :upper
               strict ? /^[A-Z0-9]+$/ : /^[A-Z0-9 ]+$/
             else
               strict ? /^[A-Za-z0-9]+$/i : /^[A-Za-z0-9 ]+$/i
             end
  end

  def valid_length?(value)
    value.present?
  end

  def valid?(value, options)
    valid_length?(value) &&
      valid_format?(value, options)
  end

end
