# frozen_string_literal: true

class BooleanValidator < ActiveModel::EachValidator

  FALSE_VALUES ||= [false, 0, '0', 'f', 'F', 'false', 'FALSE'].freeze
  TRUE_VALUES  ||= [true, 1, '1', 't', 'T', 'true', 'TRUE'].freeze

  def validate_each(record, attribute, value)
    return if TRUE_VALUES.include?(value) || FALSE_VALUES.include?(value)

    record.errors[attribute] <<
      (options[:message] || I18n.t('active_validation.errors.messages.boolean'))
  end

end
