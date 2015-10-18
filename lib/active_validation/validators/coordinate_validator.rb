class CoordinateValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    boundary = options.fetch(:boundary, :coordinate).to_sym
    unless BOUNDARIES.include?(boundary)
      raise ArgumentError,
        "Unknown boundary: #{boundary.inspect}. Valid boundaries are: #{BOUNDARIES.map(&:inspect).join(', '.freeze)}"
    end

    unless valid?(value, options)
      record.errors[attribute] << (options.fetch(:message, false) || I18n.t("active_validation.errors.messages.coordinate.#{boundary}"))
    end
  end

  private

  BOUNDARIES = [:coordinate, :latitude, :longitude].freeze

  def valid_length?(value)
    value.present?
  end

  def valid_latitude?(value)
    value >= -90 && value <= 90
  end

  def valid_longitude?(value)
    value >= -180 && value <= 180
  end

  def valid_boundary?(value, options)
    case options.fetch(:boundary, :coordinate).to_sym
    when :latitude
      valid_latitude?(value)
    when :longitude
      valid_longitude?(value)
    else
      valid_latitude?(value.first) && valid_longitude?(value.last)
    end
  end

  def valid?(value, options)
    valid_length?(value) &&
    valid_boundary?(value, options)
  end

end