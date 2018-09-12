# frozen_string_literal: true

class CusipValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    return if valid?(value.to_s)

    record.errors[attribute] <<
      (options[:message] || I18n.t('active_validation.errors.messages.cusip'))
  end

  private

  # rubocop:disable Lint/UselessAssignment
  def valid_checksum?(value)
    digits = value.chars.map { |chr| /[A-Z]/.match?(chr) ? (chr.ord - 55) : chr.to_i }
    even_values = digits.values_at(* digits.each_index.select(&:even?))
    odd_values = digits.values_at(* digits.each_index.select(&:odd?))
    values = odd_values.map { |int| int * 2 }.zip(even_values).flatten
    values = values.inject(0) { |sum, int| sum += (int / 10) + int % 10 }

    ((10 - values) % 10) % 10
  end
  # rubocop:enable Lint/UselessAssignment

  def valid_format?(value)
    value =~ /^[0-9A-Z]{9}$/
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
