# frozen_string_literal: true

class Boolean
  # Implement pseudo-boolean class
end

class TypeValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    return if valid?(value, options)

    record.errors[attribute] <<
      (options[:message] || I18n.t('active_validation.errors.messages.type'))
  end

  private

  def valid?(value, options)
    klass = options[:with]

    if klass == Boolean
      value.is_a?(TrueClass) || value.is_a?(FalseClass)
    else
      value.is_a?(klass)
    end
  end

end
