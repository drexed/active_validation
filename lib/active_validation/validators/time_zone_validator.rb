# frozen_string_literal: true

class TimeZoneValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    return if valid?(value)

    record.errors[attribute] <<
      (options[:message] || I18n.t('active_validation.errors.messages.time_zone'))
  end

  private

  def valid_time_zone?(value)
    ActiveSupport::TimeZone[value].present?
  end

  def valid_length?(value)
    value.present?
  end

  def valid?(value)
    valid_length?(value) &&
      valid_time_zone?(value)
  end

end
