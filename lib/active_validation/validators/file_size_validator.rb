class FileSizeValidator < ActiveModel::EachValidator

  CHECKS ||= %i[is minimum maximum].freeze

  def validate_each(record, attribute, value)
    unless CHECKS.any? { |key| options.key?(key) }
      raise ArgumentError,
            "Unknown check. Valid checks are: #{CHECKS.map(&:inspect).join(', ')}"
    end

    return if valid?(value)
    record.errors
          .add(attribute, options[:message] || I18n.t('active_validation.errors.messages.file_size'))
  end

  private

  def valid_is?(value)
    return true unless options[:is]
    value.size == options[:is]
  end


  def valid?(value)
    valid_is?(csv)
  end

end
