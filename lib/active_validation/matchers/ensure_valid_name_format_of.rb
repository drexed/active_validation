RSpec::Matchers.define :ensure_valid_name_format_of do |attribute|
  match do |model|
    model.send("#{attribute}=", "Jame$ Ear1 Jones")
    model.valid?

    if model.errors.has_key?(attribute)
      model.errors[attribute].include?(I18n.t('active_validation.errors.messages.name'))
    end
  end

  failure_message do |model|
    I18n.t(
      'active_validation.errors.matchers.ensure_valid_name_format_of.failure_message_for_should',
      attribute: attribute.inspect,
      model: model.class.name
    )
  end

  failure_message_when_negated do |model|
    I18n.t(
      'active_validation.errors.matchers.ensure_valid_name_format_of.failure_message_for_should_not',
      attribute: attribute.inspect,
      model: model.class.name
    )
  end
end