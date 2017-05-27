require 'spec_helper'

module CsvHelpers

  def upload_csv(file_name)
    csv_path = File.join(File.expand_path('../spec/support/csv', file_name), file_name)
    csv_file = File.open(csv_path)

    ActionDispatch::Http::UploadedFile.new(tempfile: csv_file, filename: File.basename(csv_file))
  end

end

describe CsvValidator do
  include CsvHelpers

  context 'has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :csv, :name
        validates :csv, csv: true
      end
    end

    subject { klass.new }

    it { should allow_value(upload_csv('6x4.csv')).for(:csv) }

    it { should_not allow_value(upload_csv('6x4.txt')).for(:csv) }

    it { should ensure_valid_csv_format_of(:csv) }
    it { should_not ensure_valid_csv_format_of(:name) }
  end

  context 'with :columns option has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :csv, :name
        validates :csv, csv: { columns: 6 }
      end
    end

    subject { klass.new }

    it { should allow_value(upload_csv('6x4.csv')).for(:csv) }

    it { should_not allow_value(upload_csv('5x3.csv')).for(:csv) }

    it { should ensure_valid_csv_format_of(:csv) }
    it { should_not ensure_valid_csv_format_of(:name) }
  end

  context 'with :max_columns option has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :csv, :name
        validates :csv, csv: { max_columns: 5 }
      end
    end

    subject { klass.new }

    it { should allow_value(upload_csv('5x3.csv')).for(:csv) }

    it { should_not allow_value(upload_csv('6x4.csv')).for(:csv) }

    it { should ensure_valid_csv_format_of(:csv) }
    it { should_not ensure_valid_csv_format_of(:name) }
  end

  context 'with :min_columns option has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :csv, :name
        validates :csv, csv: { min_columns: 6 }
      end
    end

    subject { klass.new }

    it { should allow_value(upload_csv('6x4.csv')).for(:csv) }

    it { should_not allow_value(upload_csv('5x3.csv')).for(:csv) }

    it { should ensure_valid_csv_format_of(:csv) }
    it { should_not ensure_valid_csv_format_of(:name) }
  end

  context 'with :rows option has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :csv, :name
        validates :csv, csv: { rows: 4 }
      end
    end

    subject { klass.new }

    it { should allow_value(upload_csv('6x4.csv')).for(:csv) }

    it { should_not allow_value(upload_csv('5x3.csv')).for(:csv) }

    it { should ensure_valid_csv_format_of(:csv) }
    it { should_not ensure_valid_csv_format_of(:name) }
  end

  context 'with :max_rows option has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :csv, :name
        validates :csv, csv: { max_rows: 3 }
      end
    end

    subject { klass.new }

    it { should allow_value(upload_csv('5x3.csv')).for(:csv) }

    it { should_not allow_value(upload_csv('6x4.csv')).for(:csv) }

    it { should ensure_valid_csv_format_of(:csv) }
    it { should_not ensure_valid_csv_format_of(:name) }
  end

  context 'with :min_rows option has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :csv, :name
        validates :csv, csv: { min_rows: 4 }
      end
    end

    subject { klass.new }

    it { should allow_value(upload_csv('6x4.csv')).for(:csv) }

    it { should_not allow_value(upload_csv('5x3.csv')).for(:csv) }

    it { should ensure_valid_csv_format_of(:csv) }
    it { should_not ensure_valid_csv_format_of(:name) }
  end

end
