class IsbnValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless valid?(value.to_s)
      record.errors[attribute] << options.fetch(:message, I18n.t("active_validation.errors.messages.isbn"))
    end
  end

  private

  CHARS_VALUES = ["0", "1", "2" , "3", "4", "5", "6", "7", "8", "9", "0", "x"]

  def valid_format?(value)
    return(false) if value.empty?
    value = value.gsub(/-| /, "").downcase.chars

    [10, 13].include?(value.size) && value.all? { |c| CHARS_VALUES.include?(c) }
  end

  def valid_length?(value)
    value.present?
  end

  def valid?(value)
    valid_length?(value) && valid_format?(value)
  end

end
