class CusipValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless valid?(value.to_s)
      record.errors[attribute] << options.fetch(:message, I18n.t("active_validation.errors.messages.cusip"))
    end
  end

  private

  def valid_checksum?(value)
    digits = value.chars.map { |c| c.match(/[A-Z]/) ? (c.ord - 55) : c.to_i }
    even_values = digits.values_at(* digits.each_index.select { |i| i.even? })
    odd_values = digits.values_at(* digits.each_index.select { |i| i.odd? })
    values = odd_values.map { |i| i * 2 }.zip(even_values).flatten
    values = values.inject(0) { |s, i| s += (i / 10) + i % 10 }

    ((10 - values) % 10) % 10
  end

  def valid_format?(value)
    value =~ /^[0-9A-Z]{9}$/
  end

  def valid_length?(value)
    value.present?
  end

  def valid?(value)
    valid_length?(value) && valid_format?(value) && valid_checksum?(value)
  end

end
