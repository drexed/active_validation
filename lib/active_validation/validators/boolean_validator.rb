class BooleanValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless [true, false, 1, 0].include?(value)
      record.errors[attribute] << (options[:message] || I18n.t('active_validation.errors.messages.boolean'))
    end
  end

end