# frozen_string_literal: true

class ImeiValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    return if valid?(value.to_s)

    record.errors[attribute] <<
      (options[:message] || I18n.t('active_validation.errors.messages.imei'))
  end

  private

  def valid_format?(value)
    value =~ /\A[\d\.\:\-\s]+\z/i
  end

  def valid_length?(value)
    value.present?
  end

  def valid_luhn?(value)
    number = value.gsub(/\D/, '').reverse

    total = 0
    number.chars.each_with_index do |chr, idx|
      result = chr.to_i
      result *= 2 if idx.odd?
      result = (1 + (result - 10)) if result >= 10
      total += result
    end

    (total % 10).zero?
  end

  def valid?(value)
    valid_length?(value) &&
      valid_format?(value) &&
      valid_luhn?(value)
  end

end
