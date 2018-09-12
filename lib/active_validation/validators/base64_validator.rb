# frozen_string_literal: true

class Base64Validator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    return if valid?(value.to_s)

    record.errors[attribute] <<
      (options[:message] || I18n.t('active_validation.errors.messages.base64'))
  end

  private

  def valid_format?(value)
    value =~ /^(?:[A-Za-z0-9+$]{4})*(?:[A-Za-z0-9+$]{2}==|[A-Za-z0-9+$]{3}=|[A-Za-z0-9+$]{4})$/
  end

  def valid_length?(value)
    value.present?
  end

  def valid?(value)
    valid_length?(value) &&
      valid_format?(value)
  end

end
