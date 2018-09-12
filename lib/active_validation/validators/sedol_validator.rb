# frozen_string_literal: true

class SedolValidator < ActiveModel::EachValidator

  WEIGHTS ||= [1, 3, 1, 7, 3, 9, 1].freeze

  def validate_each(record, attribute, value)
    return if valid?(value.to_s)

    record.errors[attribute] <<
      (options[:message] || I18n.t('active_validation.errors.messages.sedol'))
  end

  private

  def valid_checksum?(value)
    digits = value.chars.map { |dgt| /[A-Z]/.match?(dgt) ? (dgt.ord - 55) : dgt.to_i }

    total = 0
    digits.each_with_index { |dgt, idx| total += (WEIGHTS[idx] * dgt) }

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
