class TrackingNumberValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless valid?(value.to_s, options)
      record.errors[attribute] << (options[:message] || I18n.t('active_validation.errors.messages.tracking_number'))
    end
  end

  private

  DEFAULT_CARRIERS_AND_SERVICES = {
    dhl: {
      express:     /^([0-9]{9,9})([0-9])$/,
      express_air: /^([0-9]{10,10})([0-9])$/
    },
    fedex:  {
      express:    /^([0-9]{11,11})([0-9])$/,
      ground:     /^([0-9]{14,14})([0-9])$/,
      ground18:   /^[0-9]{2,2}([0-9]{15,15})([0-9])$/,
      ground96:   /^96[0-9]{5,5}([0-9]{14,14})([0-9])$/,
      smart_post: /^((?:92)?[0-9]{5}[0-9]{14})([0-9])$/
    },
    ontrac: { express: /^(C[0-9]{13,13})([0-9])$/ },
    ups:    { express: /^1Z(\w{15,15})(\w)$/ },
    usps:   {
      usps13: /^([A-Z]{2,2})([0-9]{9,9})([A-Z]{2,2})$/,
      usps20: /^([0-9]{2,2})([0-9]{9,9})([0-9]{8,8})([0-9])$/,
      usps91: /^(?:420\d{5})?(9[1-5](?:[0-9]{19}|[0-9]{23}))([0-9])$/
    }
  }

  # DHL
  DEFAULT_CARRIERS_AND_SERVICES.fetch(:dhl).each do |service, pattern|
    define_method("valid_dhl_#{service}_checksum?") do |value|
      formula = value.scan(pattern).flatten.compact
      return(false) if formula.empty?
      sequence, check_digit = formula.map(&:to_i)

      (sequence % 7) == check_digit
    end
  end

  # FedEx
  def valid_fedex_express_checksum?(value)
    return(false) unless value.size == 12

    pattern = DEFAULT_CARRIERS_AND_SERVICES.fetch(:fedex).fetch(:express)
    formula = value.scan(pattern).flatten.compact
    return(false) if formula.empty?
    sequence, check_digit = formula

    total = 0
    sequence.chars.zip([3, 1, 7, 3, 1, 7, 3, 1, 7, 3, 1]).each do |(char1, char2)|
      total += (char1.to_i * char2)
    end

    (total % 11 % 10) == check_digit.to_i
  end

  DEFAULT_CARRIERS_AND_SERVICES.fetch(:fedex).only(:ground, :ground18, :ground96).each_with_index do |(service, pattern), i|
    define_method("valid_fedex_#{service}_checksum?") do |value|
      return(false) unless value.size == [15, 18, 22].at(i)

      formula = value.scan(pattern).flatten.compact
      return(false) if formula.empty?
      sequence, check_digit = formula

      total = 0
      sequence.chars.reverse.each_with_index do |character, i|
        result = character.to_i
        result *= 3 if i.even?
        total  += result
      end

      check = total % 10
      check = (10 - check) unless check.zero?
      check == check_digit.to_i
    end
  end

  def valid_fedex_smart_post_checksum?(value)
    value = "92#{value}" unless value =~ /^92/
    return(false) unless value.size == 22

    pattern = DEFAULT_CARRIERS_AND_SERVICES.fetch(:fedex).fetch(:smart_post)
    formula = value.scan(pattern).flatten.compact
    return(false) if formula.empty?
    sequence, check_digit = formula

    total = 0
    sequence.chars.reverse.each_with_index do |character, i|
      result = character.to_i
      result *= 3 if i.even?
      total  += result
    end

    check = total % 10
    check = (10 - check) unless check.zero?
    check == check_digit.to_i
  end

  # Ontrac & UPS
  DEFAULT_CARRIERS_AND_SERVICES.only(:ontrac, :ups).each_with_index do |(carrier, services), i|
    services.each do |service, pattern|
      define_method("valid_#{carrier}_#{service}_checksum?") do |value|
        return(false) unless value.size == [15, 18].at(i)

        formula = value.scan(pattern).flatten.compact
        return(false) if formula.empty?
        sequence, check_digit = formula

        total = 0
        sequence.chars.each_with_index do |character, i|
          result = character[/[0-9]/] ? character.to_i : ((character[0].ord - 3) % 10)
          result *= 2 if i.odd?
          total  += result
        end

        check = total % 10
        check = 10 - check unless check.zero?
        check == check_digit.to_i
      end
    end
  end

  # USPS
  def valid_usps_usps13_checksum?(value)
    return(false) unless value.size == 13

    pattern  = DEFAULT_CARRIERS_AND_SERVICES.fetch(:usps).fetch(:usps13)
    sequence = value.scan(pattern).flatten.compact
    return(false) if sequence.empty?

    characters  = sequence[1].chars
    check_digit = characters.pop.to_i

    total = 0
    characters.zip([8, 6, 4, 2, 3, 5, 9, 7]).each do |pair|
      total += (pair[0].to_i * pair[1].to_i)
    end

    remainder = total % 11
    check     = case remainder
    when 1
      0
    when 0
      5
    else
      11 - remainder
    end

    check == check_digit
  end

  def valid_usps_usps20_checksum?(value)
    return(false) unless value.size == 20

    pattern  = DEFAULT_CARRIERS_AND_SERVICES.fetch(:usps).fetch(:usps20)
    sequence = value.scan(pattern).flatten.compact
    return(false) if sequence.empty?

    characters  = sequence.first(3).join.chars
    check_digit = sequence.last.to_i

    total = 0
    characters.reverse.each_with_index do |character, i|
      result = character.to_i
      result *= 3 if i.even?
      total  += result
    end

    check = total % 10
    check = (10 - check) unless check.zero?
    check == check_digit
  end

  def valid_usps_usps91_checksum?(value)
    value = "91#{value}" unless value =~ /^(420\d{5})?9[1-5]/
    return(false) unless value.size == 22

    pattern  = DEFAULT_CARRIERS_AND_SERVICES.fetch(:usps).fetch(:usps91)
    sequence = value.scan(pattern).flatten.compact
    return(false) if sequence.empty?

    characters  = sequence.first.chars
    check_digit = sequence.last.to_i

    total = 0
    characters.reverse.each_with_index do |character, i|
      result = character.to_i
      result *= 3 if i.even?
      total  += result
    end

    check = total % 10
    check = (10 - check) unless check.zero?
    check == check_digit
  end

  # Base
  def valid_checksum?(value, options)
    carrier = options[:carrier]
    service = options[:service]
    result  = false

    if carrier.nil? && service.nil?
      DEFAULT_CARRIERS_AND_SERVICES.each do |carrier, services|
        services.each_key do |carrier_service|
          result = send("valid_#{carrier}_#{carrier_service}_checksum?", value)
          break if result
        end
        break if result
      end
    elsif service.nil?
      DEFAULT_CARRIERS_AND_SERVICES.fetch(carrier).each_key do |carrier_service|
        result = send("valid_#{carrier}_#{carrier_service}_checksum?", value)
        break if result
      end
    else
      result = send("valid_#{carrier}_#{service}_checksum?", value)
    end

    return(result)
  end

  def valid_length?(value)
    value.present?
  end

  def valid?(value, options)
    valid_length?(value) &&
    valid_checksum?(value, options)
  end

end