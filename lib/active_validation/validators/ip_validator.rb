class IpValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless valid?(value.to_s)
      record.errors[attribute] <<
        (options[:message] || I18n.t('active_validation.errors.messages.ip'))
    end
  end

  private

  def valid_format?(value)
    value =~ /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/
  end

  def valid_length?(value)
    value.present?
  end

  def valid?(value)
    valid_length?(value) && valid_format?(value)
  end

end
