# frozen_string_literal: true

class PasswordValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    return if valid?(value.to_s, options)

    record.errors[attribute] <<
      (options[:message] || I18n.t('active_validation.errors.messages.password'))
  end

  private

  def valid_format?(value, options)
    value =~ if options[:strict]
               /^(?=^.{1,255}$)((?=.*[A-Za-z0-9])(?=.*[A-Z])(?=.*[a-z]))^.*$/
             else
               /^[A-Za-z0-9!@#$%^&*_-]{1,255}$/
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
