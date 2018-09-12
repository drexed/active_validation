# frozen_string_literal: true

class HexValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    return if valid?(value.to_s)

    record.errors[attribute] <<
      (options[:message] || I18n.t('active_validation.errors.messages.hex'))
  end

  private

  def valid_format?(value)
    value =~ /^#?([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/
  end

  def valid_length?(value)
    value.present?
  end

  def valid?(value)
    valid_length?(value) &&
      valid_format?(value)
  end

end
