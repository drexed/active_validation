class MacAddressValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless valid?(value.to_s)
      record.errors[attribute] <<
        (options[:message] || I18n.t('active_validation.errors.messages.mac_address'))
    end
  end

  private

  DEFAULT_FORMATS = [
    /^([\h]{2}:){5}[\h]{2}?$/i, /^([\h]{2}[-|\.|\s]){5}[\h]{2}?$/i,
    /^([\h]{6})[-|\.][\h]{6}?$/i, /^([\h]{6}):[\h]{6}?$/i,
    /^([\h]{4}[-|\.|\s]){2}[\h]{4}?$/i, /^[\h]{12}?$/i
  ]

  def valid_format?(value)
    result = false
    DEFAULT_FORMATS.each { |pat| break if result = (value =~ pat) }
    result
  end

  def valid_length?(value)
    value.present?
  end

  def valid?(value)
    valid_length?(value) && valid_format?(value)
  end

end
