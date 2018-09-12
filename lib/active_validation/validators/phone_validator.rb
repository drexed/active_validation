# frozen_string_literal: true

class PhoneValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    return if valid?(value.to_s)

    record.errors[attribute] <<
      (options[:message] || I18n.t('active_validation.errors.messages.phone'))
  end

  private

  def valid_format?(value)
    value =~ %r{^[0-9+\(\)#\.\s\/ext-]+$}
  end

  def valid_length?(value)
    value.present?
  end

  def valid?(value)
    valid_length?(value) &&
      valid_format?(value)
  end

end
