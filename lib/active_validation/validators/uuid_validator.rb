class UuidValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless valid?(value.to_s, options)
      record.errors[attribute] << (options.fetch(:message, false) || I18n.t('active_validation.errors.messages.uuid'.freeze))
    end
  end

  private

  def valid_format?(value, options)
    value =~ case options.fetch(:version, 0)
    when 3
      /^[0-9A-F]{8}-[0-9A-F]{4}-3[0-9A-F]{3}-[0-9A-F]{4}-[0-9A-F]{12}$/i
    when 4
      /^[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$/i
    when 5
      /^[0-9A-F]{8}-[0-9A-F]{4}-5[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$/i
    else
      /^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}$/i
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