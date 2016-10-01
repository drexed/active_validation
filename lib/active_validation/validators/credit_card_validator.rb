class CreditCardValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    return if valid?(value.to_s, options)
    record.errors[attribute] <<
      (options[:message] || I18n.t('active_validation.errors.messages.credit_card'))
  end

  private

  DEFAULT_LENGTHS ||= {
    american_express: [15], diners_club: [14, 16], discover: [16], jcb: [16],
    laser: [16, 17, 18, 19], maestro: [12, 13, 14, 15, 16, 17, 18, 19],
    mastercard: [16], solo: [16, 18, 19], unionpay: [16, 17, 18, 19], visa: [16]
  }.freeze

  # rubocop:disable Style/IndentArray
  DEFAULT_PREFIXES ||= {
    american_express: %w(34 37),
    diners_club: %w(300 301 302 303 304 305 36 54 55),
    discover: %w(
                  6011 622126 622127 622128 622129 62213 62214 62215 62216 62217 62218 62219 6222
                  6223 6224 6225 6226 6227 6228 62290 62291 622920 622921 622922 622923 622924
                  622925 644 645 646 647 648 649 65
                ),
    jcb: %w(3528 3529 353 354 355 356 357 358),
    laser: %w(6304 6706 6771 6709),
    maestro: %w(5018 5020 5038 6304 6759 6761 6762 6763 6764 6765 6766),
    mastercard: %w(51 52 53 54 55),
    solo: %w(6334 6767),
    unionpay: %w(
                  622126 622127 622128 622129 62213 62214 62215 62216 62217 62218 62219 6222 6223
                  6224 6225 6226 6227 6228 62290 62291 622920 622921 622922 622923 622924 622925
                ),
    visa: %w(4)
  }.freeze
  # rubocop:enable Style/IndentArray

  def valid_format?(value, options)
    value =~ (options[:strict] ? /^[0-9]+$/ : /^[0-9 -.]+$/)
  end

  def valid_length?(value, options)
    return(false) unless value.present?

    current_card = options[:card] || :all
    value_size = value.size

    case current_card
    when :amex
      DEFAULT_LENGTHS[:american_express].include?(value_size)
    when :all
      value_size_range = DEFAULT_LENGTHS.values.flatten.uniq.sort
      value_size.between?(value_size_range.first, value_size_range.last)
    else
      DEFAULT_LENGTHS[current_card].include?(value_size)
    end
  end

  def valid_prefix?(value, options)
    current_card = options[:card] || :all

    case current_card
    when :amex
      DEFAULT_PREFIXES[:american_express].any? { |pat| value.start_with?(pat) }
    when :all
      result = false
      DEFAULT_LENGTHS.each do |key, values|
        if values.include?(value.size)
          result = DEFAULT_PREFIXES[key].any? { |pat| value.start_with?(pat) }
          break if result
        end
      end
      result
    else
      DEFAULT_PREFIXES[current_card].any? { |pat| value.start_with?(pat) }
    end
  end

  def valid?(value, options)
    striped_value = value.gsub(/\D/, '')

    valid_format?(value, options) &&
      valid_length?(striped_value, options) &&
      valid_prefix?(striped_value, options)
  end

end
