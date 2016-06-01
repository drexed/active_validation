class ImeiValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless valid?(value.to_s)
      record.errors[attribute] << options.fetch(:message, I18n.t("active_validation.errors.messages.imei"))
    end
  end

  private

  def valid_format?(value)
    value =~ /\A[\d\.\:\-\s]+\z/i
  end

  def valid_length?(value)
    value.present?
  end

  def valid_luhn?(value)
    number = value.gsub(/\D/, "").reverse

    total = 0
    number.chars.each_with_index do |c, i|
      result = c.to_i
      result *= 2 if i.odd?
      result = (1 + (result - 10)) if (result >= 10)
      total += result
    end

    (total % 10).zero?
  end

  def valid?(value)
    valid_length?(value) && valid_format?(value) && valid_luhn?(value)
  end

end
