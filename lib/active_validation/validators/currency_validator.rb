class CurrencyValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless valid?(value.to_s, options)
      record.errors[attribute] << (options.fetch(:message, false) || I18n.t('active_validation.errors.messages.currency'.freeze))
    end
  end

  private

  def valid_format?(value, options)
    value =~ (options.fetch(:strict, false) ? /^\d+(\.\d{2})$/ : /^\d*+(\.\d{1,2})$/)
  end

  def valid_length?(value)
    value.present?
  end

  def valid?(value, options)
    valid_length?(value) &&
    valid_format?(value, options)
  end

end