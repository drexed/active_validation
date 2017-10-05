# frozen_string_literal: true

RSpec::Matchers.define :ensure_valid_csv_format_of do |attribute|
  match do |model|
    file_name = 'csv.txt'
    csv_file = File.expand_path('../spec/support/txt', file_name)
    csv_file = File.join(csv_file, file_name)
    csv_file = File.open(csv_file)
    csv_file = ActionDispatch::Http::UploadedFile.new(tempfile: csv_file, filename: file_name)

    model.send("#{attribute}=", csv_file)
    model.valid?

    if model.errors.has_key?(attribute)
      model.errors[attribute].include?(I18n.t('active_validation.errors.messages.csv'))
    end
  end

  failure_message do |model|
    I18n.t(
      'active_validation.errors.matchers.ensure_valid_csv_format_of.failure_message_for_should',
      attr: attribute.inspect,
      model: model.class.name
    )
  end

  failure_message_when_negated do |model|
    I18n.t(
      'active_validation.errors.matchers.ensure_valid_csv_format_of.failure_message_for_should_not',
      attr: attribute.inspect,
      model: model.class.name
    )
  end
end
