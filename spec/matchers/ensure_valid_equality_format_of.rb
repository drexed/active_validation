# frozen_string_literal: true

RSpec::Matchers.define :ensure_equality_of do |attribute|
  chain :to do |to|
    @to = to
  end

  chain :operator do |operator|
    @operator = operator
  end

  match do |model|
    raise Exception if @to.nil? || @operator.nil?

    value = model.send(attribute)
    model.send("#{@to}=", value)
    model.send("#{@operator}=", value)
    model.valid?

    if model.errors.has_key?(attribute)
      model.errors[attribute].include?(I18n.t('active_validation.errors.messages.equality', attr: @to, operator: @operator))
    end
  end

  failure_message do |model|
    I18n.t(
      'active_validation.errors.matchers.ensure_valid_equality_format_of.failure_message_for_should',
      attr: attribute.inspect,
      model: model.class.name,
      operator: 'operator'
    )
  end

  failure_message_when_negated do |model|
    I18n.t(
      'active_validation.errors.matchers.ensure_valid_equality_format_of.failure_message_for_should_not',
      attr: attribute.inspect,
      model: model.class.name,
      operator: 'operator'
    )
  end
end
