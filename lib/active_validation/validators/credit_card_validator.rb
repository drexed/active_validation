class CreditCardValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless valid?(value.to_s, options)
      record.errors[attribute] << (options[:message] || I18n.t('active_validation.errors.messages.credit_card'))
    end
  end

  private

  DEFAULT_LENGTHS = {
    american_express: [15],
    diners_club: [14, 16],
    discover: [16],
    jcb: [16],
    laser: [16, 17, 18, 19],
    maestro: [12, 13, 14, 15, 16, 17, 18, 19],
    mastercard: [16],
    solo: [16, 18, 19],
    unionpay: [16, 17, 18, 19],
    visa: [16]
  }

  DEFAULT_PREFIXES = {
    american_express: ['34', '37'],
    diners_club: ['300', '301', '302', '303', '304', '305', '36', '54', '55'],
    discover: [
      '6011', '622126', '622127', '622128', '622129', '62213',
      '62214', '62215', '62216', '62217', '62218', '62219',
      '6222', '6223', '6224', '6225', '6226', '6227', '6228',
      '62290', '62291', '622920', '622921', '622922', '622923',
      '622924', '622925', '644', '645', '646', '647', '648',
      '649', '65'
    ],
    jcb: ['3528', '3529', '353', '354', '355', '356', '357', '358'],
    laser: ['6304', '6706', '6771', '6709'],
    maestro: [
      '5018', '5020', '5038', '6304', '6759', '6761', '6762',
      '6763', '6764', '6765', '6766'
    ],
    mastercard: ['51', '52', '53', '54', '55'],
    solo: ['6334', '6767'],
    unionpay: [
      '622126', '622127', '622128', '622129', '62213', '62214',
      '62215', '62216', '62217', '62218', '62219', '6222', '6223',
      '6224', '6225', '6226', '6227', '6228', '62290', '62291',
      '622920', '622921', '622922', '622923', '622924', '622925'
    ],
    visa: ['4']
  }

  def valid_format?(value, options)
    value =~ (options.fetch(:strict, false) ? /^[0-9]+$/ : /^[0-9 -.]+$/)
  end

  def valid_length?(value, options)
    return(false) unless value.present?

    value_size_range = DEFAULT_LENGTHS.values.flatten.uniq.sort
    value_size       = value.size

    case options[:card]
    when :american_express, :amex
      DEFAULT_LENGTHS[:american_express].include?(value_size)
    when :diners_club
      DEFAULT_LENGTHS[:diners_club].include?(value_size)
    when :discover
      DEFAULT_LENGTHS[:discover].include?(value_size)
    when :jcb
      DEFAULT_LENGTHS[:jcb].include?(value_size)
    when :laser
      DEFAULT_LENGTHS[:laser].include?(value_size)
    when :maestro
      DEFAULT_LENGTHS[:maestro].include?(value_size)
    when :mastercard
      DEFAULT_LENGTHS[:mastercard].include?(value_size)
    when :solo
      DEFAULT_LENGTHS[:solo].include?(value_size)
    when :unionpay
      DEFAULT_LENGTHS[:unionpay].include?(value_size)
    when :visa
      DEFAULT_LENGTHS[:visa].include?(value_size)
    else
      value_size.between?(value_size_range.first, value_size_range.last)
    end
  end

  def valid_prefix?(value, options)
    value_size = value.size

    case options[:card]
    when :american_express, :amex
      DEFAULT_PREFIXES[:american_express].any? { |prefix| value.start_with?(prefix) }
    when :diners_club
      DEFAULT_PREFIXES[:diners_club].any? { |prefix| value.start_with?(prefix) }
    when :discover
      DEFAULT_PREFIXES[:discover].any? { |prefix| value.start_with?(prefix) }
    when :jcb
      DEFAULT_PREFIXES[:jcb].any? { |prefix| value.start_with?(prefix) }
    when :laser
      DEFAULT_PREFIXES[:laser].any? { |prefix| value.start_with?(prefix) }
    when :maestro
      DEFAULT_PREFIXES[:maestro].any? { |prefix| value.start_with?(prefix) }
    when :mastercard
      DEFAULT_PREFIXES[:mastercard].any? { |prefix| value.start_with?(prefix) }
    when :solo
      DEFAULT_PREFIXES[:solo].any? { |prefix| value.start_with?(prefix) }
    when :unionpay
      DEFAULT_PREFIXES[:unionpay].any? { |prefix| value.start_with?(prefix) }
    when :visa
      DEFAULT_PREFIXES[:visa].any? { |prefix| value.start_with?(prefix) }
    else
      result = false
      DEFAULT_LENGTHS.each do |key, values|
        if values.include?(value_size)
          result = DEFAULT_PREFIXES[key].any? { |prefix| value.start_with?(prefix) }
          break if result
        end
        break if result
      end
      return(result)
    end
  end

  def valid?(value, options)
    striped_value = value.gsub(/\D/, '')

    valid_format?(value, options) &&
    valid_length?(striped_value, options) &&
    valid_prefix?(striped_value, options)
  end

end