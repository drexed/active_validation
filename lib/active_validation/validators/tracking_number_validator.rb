# frozen_string_literal: true

class TrackingNumberValidator < ActiveModel::EachValidator

  CARRIERS_AND_SERVICES ||= {
    dhl: {
      express: /^([0-9]{9,9})([0-9])$/,
      express_air: /^([0-9]{10,10})([0-9])$/
    },
    fedex: {
      express: /^([0-9]{11,11})([0-9])$/,
      ground: /^([0-9]{14,14})([0-9])$/,
      ground18: /^[0-9]{2,2}([0-9]{15,15})([0-9])$/,
      ground96: /^96[0-9]{5,5}([0-9]{14,14})([0-9])$/,
      smart_post: /^((?:92)?[0-9]{5}[0-9]{14})([0-9])$/
    },
    ontrac: { express: /^(C[0-9]{13,13})([0-9])$/ },
    ups: { express: /^1Z(\w{15,15})(\w)$/ },
    usps: {
      usps13: /^([A-Z]{2,2})([0-9]{9,9})([A-Z]{2,2})$/,
      usps20: /^([0-9]{2,2})([0-9]{9,9})([0-9]{8,8})([0-9])$/,
      usps91: /^(?:420\d{5})?(9[1-5](?:[0-9]{19}|[0-9]{23}))([0-9])$/
    }
  }.freeze

  def validate_each(record, attribute, value)
    return if valid?(value.to_s, options)

    record.errors[attribute] <<
      (options[:message] || I18n.t('active_validation.errors.messages.tracking_number'))
  end

  private

  # DHL
  CARRIERS_AND_SERVICES[:dhl].each do |srv, pat|
    define_method("valid_dhl_#{srv}_checksum?") do |val|
      formula = val.scan(pat).flatten.compact
      return(false) if formula.empty?

      sequence, check_digit = formula.map(&:to_i)

      (sequence % 7) == check_digit
    end
  end

  # FedEx
  def valid_fedex_express_checksum?(value)
    return(false) unless value.size == 12

    pattern = CARRIERS_AND_SERVICES[:fedex][:express]
    formula = value.scan(pattern).flatten.compact
    return(false) if formula.empty?

    sequence, check_digit = formula

    total = 0
    sequence.chars.zip([3, 1, 7, 3, 1, 7, 3, 1, 7, 3, 1]).each do |chr, chrx|
      total += (chr.to_i * chrx)
    end

    (total % 11 % 10) == check_digit.to_i
  end

  CARRIERS_AND_SERVICES[:fedex]
    .select { |key, _| %i[ground ground18 ground96].include?(key) }
    .each_with_index do |(srv, pat), idx|
      define_method("valid_fedex_#{srv}_checksum?") do |val|
        return(false) unless val.size == [15, 18, 22].at(idx)

        formula = val.scan(pat).flatten.compact
        return(false) if formula.empty?

        sequence, check_digit = formula

        total = 0
        sequence.chars.reverse.each_with_index do |chr, idxx|
          result = chr.to_i
          result *= 3 if idxx.even?
          total += result
        end

        check = total % 10
        check = (10 - check) unless check.zero?
        check == check_digit.to_i
      end
    end

  def valid_fedex_smart_post_checksum?(value)
    value = "92#{value}" unless /^92/.match?(value)
    return(false) unless value.size == 22

    pattern = CARRIERS_AND_SERVICES[:fedex][:smart_post]
    formula = value.scan(pattern).flatten.compact
    return(false) if formula.empty?

    sequence, check_digit = formula

    total = 0
    sequence.chars.reverse.each_with_index do |chr, idx|
      result = chr.to_i
      result *= 3 if idx.even?
      total += result
    end

    check = total % 10
    check = (10 - check) unless check.zero?
    check == check_digit.to_i
  end

  # Ontrac & UPS
  CARRIERS_AND_SERVICES
    .select { |key, _| %i[ontrac ups].include?(key) }
    .each_with_index do |(cars, sers), idx|
      sers.each do |ser, pat|
        define_method("valid_#{cars}_#{ser}_checksum?") do |val|
          return(false) unless val.size == [15, 18].at(idx)

          formula = val.scan(pat).flatten.compact
          return(false) if formula.empty?

          sequence, check_digit = formula

          total = 0
          sequence.chars.each_with_index do |chr, idxx|
            result = chr[/[0-9]/] ? chr.to_i : ((chr[0].ord - 3) % 10)
            result *= 2 if idxx.odd?
            total += result
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

    pattern = CARRIERS_AND_SERVICES[:usps][:usps13]
    sequence = value.scan(pattern).flatten.compact
    return(false) if sequence.empty?

    characters = sequence[1].chars
    check_digit = characters.pop.to_i

    total = 0
    characters.zip([8, 6, 4, 2, 3, 5, 9, 7]).each do |par|
      total += (par[0].to_i * par[1].to_i)
    end

    remainder = total % 11
    check = case remainder
            when 1 then 0
            when 0 then 5
            else
              11 - remainder
            end

    check == check_digit
  end

  def valid_usps_usps20_checksum?(value)
    return(false) unless value.size == 20

    pattern = CARRIERS_AND_SERVICES[:usps][:usps20]
    sequence = value.scan(pattern).flatten.compact
    return(false) if sequence.empty?

    characters = sequence.first(3).join.chars
    check_digit = sequence.last.to_i

    total = 0
    characters.reverse.each_with_index do |chr, idx|
      result = chr.to_i
      result *= 3 if idx.even?
      total += result
    end

    check = total % 10
    check = (10 - check) unless check.zero?
    check == check_digit
  end

  def valid_usps_usps91_checksum?(value)
    value = "91#{value}" unless /^(420\d{5})?9[1-5]/.match?(value)
    return(false) unless value.size == 22

    pattern = CARRIERS_AND_SERVICES[:usps][:usps91]
    sequence = value.scan(pattern).flatten.compact
    return(false) if sequence.empty?

    characters = sequence.first.chars
    check_digit = sequence.last.to_i

    total = 0
    characters.reverse.each_with_index do |chr, idx|
      result = chr.to_i
      result *= 3 if idx.even?
      total += result
    end

    check = total % 10
    check = (10 - check) unless check.zero?
    check == check_digit
  end

  # Base
  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def valid_checksum?(value, options)
    carrier = options[:carrier]
    service = options[:service]
    result = false

    if carrier.nil? && service.nil?
      CARRIERS_AND_SERVICES.each do |car, ser|
        ser.each_key do |car_ser|
          result = send("valid_#{car}_#{car_ser}_checksum?", value)
          break if result
        end
        break if result
      end
    elsif service.nil?
      CARRIERS_AND_SERVICES[carrier].each_key do |car_ser|
        result = send("valid_#{carrier}_#{car_ser}_checksum?", value)
        break if result
      end
    else
      result = send("valid_#{carrier}_#{service}_checksum?", value)
    end

    result
  end
  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  def valid_length?(value)
    value.present?
  end

  def valid?(value, options)
    valid_length?(value) &&
      valid_checksum?(value, options)
  end

end
