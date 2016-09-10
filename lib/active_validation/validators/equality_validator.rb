class EqualityValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    to = options.fetch(:to, nil)
    if to.nil?
      raise ArgumentError,
        "ArgumentError: missing ':to' attribute for comparison."
    end

    operator = options.fetch(:operator, nil)
    operators = OPERATORS.keys
    unless operators.include?(operator)
      raise ArgumentError,
        "Unknown operator: #{operator.inspect}. Valid operators are: #{operators.map(&:inspect).join(", ")}"
    end
    operator = OPERATORS.fetch(operator)

    unless value.send(operator, record.send(to))
      record.errors[attribute] << options.fetch(:message, I18n.t("active_validation.errors.messages.equality", attr: to, operator: operator))
    end
  end

  private

  OPERATORS = {
    less_than: :<, less_than_or_equal_to: :<=, greater_than: :>,
    greater_than_or_equal_to: :>=, equal_to: :==, not_equal_to: :!=
  }

end