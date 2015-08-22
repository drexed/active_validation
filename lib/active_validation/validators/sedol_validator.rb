class SedolValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless valid?(value.to_s)
      record.errors[attribute] << (options[:message] || I18n.t('active_validation.errors.messages.sedol'))
    end
  end

  private

  def valid_checksum?(value)
    digits  = value.chars.map { |digit| digit.match(/[A-Z]/) ? (digit.ord - 55) : digit.to_i }
    weights = [1, 3, 1, 7, 3, 9, 1]

    total = 0
    digits.each_with_index do |digit, i|
      total += (weights[i] * digit)
    end

    (10 - total % 10) % 10
  end

  def valid_format?(value)
    value =~ /^([A-Z0-9]{6})(\d{1})$/
  end

  def valid_length?(value)
    value.present?
  end

  def valid?(value)
    valid_length?(value) &&
    valid_format?(value) &&
    valid_checksum?(value)
  end

end