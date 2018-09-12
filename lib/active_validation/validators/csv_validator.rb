# frozen_string_literal: true

require 'csv'

class CsvValidator < ActiveModel::EachValidator

  CHECKS ||= {
    columns: :==,
    columns_in: :===,
    columns_less_than: :<,
    columns_less_than_or_equal_to: :<=,
    columns_greater_than: :>,
    columns_greater_than_or_equal_to: :>=,
    rows: :==,
    rows_in: :===,
    rows_less_than: :<,
    rows_less_than_or_equal_to: :<=,
    rows_greater_than: :>,
    rows_greater_than_or_equal_to: :>=
  }.freeze

  def validate_each(record, attribute, value)
    assert_valid_options!
    values = parse_values(record, attribute, value)

    if values.nil?
      record.errors.add(attribute, 'not a valid csv')
      return
    end

    options.slice(*CHECKS.keys).each do |option, option_value|
      option_value = option_value.call(record) if option_value.is_a?(Proc)

      next unless values.any? { |val| !valid_size?(val, option, option_value) }

      error_text = filtered_options(values).merge!(detect_error_options(option_value))
      error_text = options[:message] ||
                   I18n.t("active_validation.errors.messages.csv.#{option}", error_text)
      record.errors[attribute] << (options[:message] || error_text)
    end
  end

  private

  def assert_valid_options!
    unless (CHECKS.keys & options.keys).present?
      raise ArgumentError,
            "You must at least pass in one of these options - #{CHECKS.map(&:inspect).join(', ')}"
    end

    check_options(Numeric, options.slice(*(CHECKS.keys - %i[columns_in rows_in])))
    check_options(Range, options.slice(:columns_in, :rows_in))
  end

  # rubocop:disable Lint/RescueException
  def valid_extension?(record, attribute, value)
    value.path.end_with?('.csv')
  rescue Exception
    record.errors[attribute] <<
      (options[:message] || I18n.t('active_validation.errors.messages.csv.not_valid'))
    false
  end
  # rubocop:enable Lint/RescueException

  def parse_values(record, attribute, value)
    return nil unless valid_extension?(record, attribute, value)

    [CSV.read(value.path)]
  rescue CSV::MalformedCSVError
    record.errors[attribute] <<
      (options[:message] || I18n.t('active_validation.errors.messages.csv.not_valid'))
    nil
  end

  def check_options(klass, options)
    options.each do |option, value|
      next if value.is_a?(klass) || value.is_a?(Proc)

      raise ArgumentError,
            ":#{option} must be a #{klass.name.to_s.downcase} or a proc"
    end
  end

  def valid_size?(value, option, option_value)
    size = /columns/.match?(option) ? value.first.length : value.length

    return false if size.zero?
    return option_value.send(CHECKS[option], size) if option_value.is_a?(Range)

    size.send(CHECKS[option], option_value)
  end

  def filtered_options(value)
    filtered = options.except(*CHECKS.keys)
    filtered[:value] = value
    filtered
  end

  def detect_error_options(option_value)
    return { count: option_value } unless option_value.is_a?(Range)

    { min: option_value.min, max: option_value.max }
  end

end
