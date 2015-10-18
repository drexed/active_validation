class PhoneValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless valid?(value.to_s)
      record.errors[attribute] << (options.fetch(:message, false) || I18n.t('active_validation.errors.messages.phone'.freeze))
    end
  end

  private

  def valid_format?(value)
    value =~ /^[0-9+\(\)#\.\s\/ext-]+$/i
  end

  def valid_length?(value)
    value.present?
  end

  def valid?(value)
    valid_length?(value) &&
    valid_format?(value)
  end

end