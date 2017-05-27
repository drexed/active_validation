require 'csv'

class CsvValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    return if valid?(value)
    record.errors
          .add(attribute, options[:message] || I18n.t('active_validation.errors.messages.csv'))
  end

  private

  def valid_extension?(value)
    value.path.end_with?('.csv') rescue false
  end

  def valid_columns?(csv)
    return true unless options[:columns]
    csv.first.length == options[:columns]
  end

  def valid_max_columns?(csv)
    return true unless options[:max_columns]
    csv.first.length <= options[:max_columns]
  end

  def valid_min_columns?(csv)
    return true unless options[:min_columns]
    csv.first.length >= options[:min_columns]
  end

  def valid_rows?(csv)
    return true unless options[:rows]
    csv.length == options[:rows]
  end

  def valid_max_rows?(csv)
    return true unless options[:max_rows]
    csv.length <= options[:max_rows]
  end

  def valid_min_rows?(csv)
    return true unless options[:min_rows]
    csv.length >= options[:min_rows]
  end

  def valid?(value)
    return unless valid_extension?(value)
    csv = CSV.read(value.path)
  rescue CSV::MalformedCSVError
    return false
  else
    valid_columns?(csv) &&
      valid_max_columns?(csv) &&
      valid_min_columns?(csv) &&
      valid_rows?(csv) &&
      valid_max_rows?(csv) &&
      valid_min_rows?(csv)
  end

end
