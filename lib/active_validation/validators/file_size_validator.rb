# frozen_string_literal: true

class FileSizeValidator < ActiveModel::EachValidator

  CHECKS ||= {
    in: :===,
    less_than: :<,
    less_than_or_equal_to: :<=,
    greater_than: :>,
    greater_than_or_equal_to: :>=
  }.freeze

  def validate_each(record, attribute, value)
    assert_valid_options!
    values = parse_values(value)
    return if values.empty?

    options.slice(*CHECKS.keys).each do |option, option_value|
      option_value = option_value.call(record) if option_value.is_a?(Proc)

      next unless values.any? { |val| !valid_size?(val.size, option, option_value) }

      error_text = filtered_options(values).merge!(detect_error_options(option_value))
      error_text = options[:message] ||
                   I18n.t("active_validation.errors.messages.file_size.#{option}", error_text)
      record.errors[attribute] << (options[:message] || error_text)
    end
  end

  private

  def assert_valid_options!
    unless (CHECKS.keys & options.keys).present?
      raise ArgumentError,
            "You must at least pass in one of these options - #{CHECKS.map(&:inspect).join(', ')}"
    end

    check_options(Numeric, options.slice(*(CHECKS.keys - %i[in])))
    check_options(Range, options.slice(:in))
  end

  def parse_values(value)
    return [] unless value.present?

    value = JSON.parse(value) if value.is_a?(String)
    return [] unless value.present?

    value = OpenStruct.new(value) if value.is_a?(Hash)
    [value].reject(&:blank?)
  end

  def check_options(klass, options)
    options.each do |option, value|
      next if value.is_a?(klass) || value.is_a?(Proc)

      raise ArgumentError,
            ":#{option} must be a #{klass.name.to_s.downcase} or a proc"
    end
  end

  def valid_size?(size, option, option_value)
    return false if size.nil?
    return option_value.send(CHECKS[option], size) if option_value.is_a?(Range)

    size.send(CHECKS[option], option_value)
  end

  def filtered_options(value)
    filtered = options.except(*CHECKS.keys)
    filtered[:value] = value
    filtered
  end

  def detect_error_options(option_value)
    return { count: human_size(option_value) } unless option_value.is_a?(Range)

    { min: human_size(option_value.min), max: human_size(option_value.max) }
  end

  def human_size(size)
    if defined?(ActiveSupport::NumberHelper)
      ActiveSupport::NumberHelper.number_to_human_size(size)
    else
      opts = { locale: options[:locale], raise: true }
      format = I18n.t(:'number.human.storage_units.format', opts)
      unit = I18n.t(:'number.human.storage_units.units.byte', opts.merge(count: size.to_i))
      format.gsub(/%n/, size.to_i.to_s).gsub(/%u/, unit).html_safe
    end
  end

end
