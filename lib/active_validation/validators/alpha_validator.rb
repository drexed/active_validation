# frozen_string_literal: true

class AlphaValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    return if valid?(value.to_s, options)

    record.errors[attribute] <<
      (options[:message] || I18n.t('active_validation.errors.messages.alpha'))
  end

  private

  def valid_format?(value, options)
    strict = options[:strict]

    value =~ case options[:case]
             when :lower
               strict ? /^[a-z]+$/ : /^[a-z ]+$/
             when :upper
               strict ? /^[A-Z]+$/ : /^[A-Z ]+$/
             else
               strict ? /^[A-Za-z]+$/i : /^[A-Za-z ]+$/i
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
