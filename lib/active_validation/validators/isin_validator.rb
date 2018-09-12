# frozen_string_literal: true

class IsinValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    return if valid?(value.to_s)

    record.errors[attribute] <<
      (options[:message] || I18n.t('active_validation.errors.messages.isin'))
  end

  private

  def valid_checksum?(value)
    characters = value.chars
    digits = characters.map { |chr| /[A-Z]/.match?(chr) ? (chr.ord - 55) : chr.to_i }
    even_values = digits.values_at(*digits.each_index.select(&:even?))
    odd_values = digits.values_at(*digits.each_index.select(&:odd?))

    longest, shortest = if even_values.last == characters.map(&:to_i)
                          [even_values, odd_values]
                        else
                          [odd_values, even_values]
                        end

    longest = longest.map { |int| int * 2 }
    values = longest.concat(shortest).to_s.scan(/./).map(&:to_i)
    total = values.inject(&:+)

    (10 - (total % 10)) % 10
  end

  # rubocop:disable Metrics/LineLength
  def valid_format?(value)
    value =~ /^((AF|AX|AL|DZ|AS|AD|AO|AI|AQ|AG|AR|AM|AW|AU|AT|AZ|BS|BH|BD|BB|BY|BE|BZ|BJ|BM|BT|BO|BQ|BA|BW|BV|BR|IO|BN|BG|BF|BI|KH|CM|CA|CV|KY|CF|TD|CL|CN|CX|CC|CO|KM|CG|CD|CK|CR|CI|HR|CU|CW|CY|CZ|DK|DJ|DM|DO|EC|EG|SV|GQ|ER|EE|ET|FK|FO|FJ|FI|FR|GF|PF|TF|GA|GM|GE|DE|GH|GI|GR|GL|GD|GP|GU|GT|GG|GN|GW|GY|HT|HM|VA|HN|HK|HU|IS|IN|ID|IR|IQ|IE|IM|IL|IT|JM|JP|JE|JO|KZ|KE|KI|KP|KR|KW|KG|LA|LV|LB|LS|LR|LY|LI|LT|LU|MO|MK|MG|MW|MY|MV|ML|MT|MH|MQ|MR|MU|YT|MX|FM|MD|MC|MN|ME|MS|MA|MZ|MM|NA|NR|NP|NL|NC|NZ|NI|NE|NG|NU|NF|MP|NO|OM|PK|PW|PS|PA|PG|PY|PE|PH|PN|PL|PT|PR|QA|RE|RO|RU|RW|BL|SH|KN|LC|MF|PM|VC|WS|SM|ST|SA|SN|RS|SC|SL|SG|SX|SK|SI|SB|SO|ZA|GS|SS|ES|LK|SD|SR|SJ|SZ|SE|CH|SY|TW|TJ|TZ|TH|TL|TG|TK|TO|TT|TN|TR|TM|TC|TV|UG|UA|AE|GB|US|UM|UY|UZ|VU|VE|VN|VG|VI|WF|EH|YE|ZM|ZW{2})([A-Z0-9]{9}))(\d{1})$/
  end
  # rubocop:enable Metrics/LineLength

  def valid_length?(value)
    value.present?
  end

  def valid?(value)
    valid_length?(value) &&
      valid_format?(value) &&
      valid_checksum?(value)
  end

end
