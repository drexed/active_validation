# frozen_string_literal: true

RSpec::Matchers.define :ensure_valid_phone_format_of do |attribute|
  match do |model|
    model.send("#{attribute}=", '555-123n')
    model.valid?

    if model.errors.has_key?(attribute)
      model.errors[attribute].include?(I18n.t('active_validation.errors.messages.phone'))
    end
  end

  failure_message do |model|
    I18n.t(
      'active_validation.errors.matchers.ensure_valid_phone_format_of.failure_message_for_should',
      attr: attribute.inspect,
      model: model.class.name
    )
  end

  failure_message_when_negated do |model|
    I18n.t(
      'active_validation.errors.matchers.ensure_valid_phone_format_of.failure_message_for_should_not',
      attr: attribute.inspect,
      model: model.class.name
    )
  end
end
