# frozen_string_literal: true

class SsnValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    return if valid?(value.to_s)

    record.errors[attribute] <<
      (options[:message] || I18n.t('active_validation.errors.messages.ssn'))
  end

  private

  def valid_format?(value)
    value =~ /^\A([\d]{3}\-[\d]{2}\-[\d]{4}|[\d]{9})\Z$/
  end

  def valid_length?(value)
    value.present?
  end

  def valid?(value)
    valid_length?(value) &&
      valid_format?(value)
  end

end
