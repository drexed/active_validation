RSpec::Matchers.define :ensure_valid_csv_format_of do |attribute|
  match do |model|
    file_name = '6x4.txt'
    csv_path = File.join(File.expand_path('../spec/support/csv', file_name), file_name)
    csv_file = File.open(csv_path)
    csv_file = ActionDispatch::Http::UploadedFile.new(tempfile: csv_file, filename: File.basename(csv_file))

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
