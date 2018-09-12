# frozen_string_literal: true

class EqualityValidator < ActiveModel::EachValidator

  OPERATORS ||= {
    less_than: :<,
    less_than_or_equal_to: :<=,
    greater_than: :>,
    greater_than_or_equal_to: :>=,
    equal_to: :==,
    not_equal_to: :!=
  }.freeze

  # rubocop:disable Metrics/LineLength
  def validate_each(record, attribute, value)
    to = options[:to]
    if to.nil?
      raise ArgumentError,
            'ArgumentError: missing ":to" attribute for comparison.'
    end

    operator = options[:operator]
    operators = OPERATORS.keys
    unless operators.include?(operator)
      raise ArgumentError,
            "Unknown operator: #{operator.inspect}. Valid operators are: #{operators.map(&:inspect).join(', ')}"
    end

    operator = OPERATORS[operator]
    return if value.send(operator, record.send(to))

    record.errors[attribute] <<
      (options[:message] || I18n.t('active_validation.errors.messages.equality', attr: to, operator: operator))
  end
  # rubocop:enable Metrics/LineLength

end
