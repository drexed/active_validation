class PasswordValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless valid?(value.to_s, options)
      record.errors[attribute] << options.fetch(:message, I18n.t("active_validation.errors.messages.password"))
    end
  end

  private

  def valid_format?(value, options)
    value =~ (options.fetch(:strict, false) ? /^(?=^.{1,255}$)((?=.*[A-Za-z0-9])(?=.*[A-Z])(?=.*[a-z]))^.*$/ : /^[A-Za-z0-9!@#$%^&*_-]{1,255}$/)
  end

  def valid_length?(value)
    value.present?
  end

  def valid?(value, options)
    valid_length?(value) && valid_format?(value, options)
  end

end
