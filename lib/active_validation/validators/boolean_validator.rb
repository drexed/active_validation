class BooleanValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless TRUE_VALUES.include?(value) || FALSE_VALUES.include?(value)
      record.errors[attribute] << (options.fetch(:message, false) || I18n.t('active_validation.errors.messages.boolean'.freeze))
    end
  end

  private

  FALSE_VALUES = [false, 0, '0', 'f', 'F', 'false', 'FALSE'].freeze
  TRUE_VALUES  = [true, 1, '1', 't', 'T', 'true', 'TRUE'].freeze

end