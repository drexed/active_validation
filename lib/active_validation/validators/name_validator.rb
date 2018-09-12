# frozen_string_literal: true

class NameValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    return if valid?(value.to_s)

    record.errors[attribute] <<
      (options[:message] || I18n.t('active_validation.errors.messages.name'))
  end

  private

  def valid_format?(value)
    value =~ /\A([a-zA-Z'"-]+\s+){1,4}[a-zA-Z'"-]*\z/i
  end

  def valid_length?(value)
    value.present?
  end

  def valid?(value)
    valid_length?(value) &&
      valid_format?(value)
  end

end
