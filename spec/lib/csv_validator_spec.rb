require 'spec_helper'
require 'support/helpers/file_helper'

describe CsvValidator do
  include FileHelper

  context 'with :columns option has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :csv, :name
        validates :csv, csv: { columns: 6 }
      end
    end

    subject { klass.new }

    it { should allow_value(csv_upload('6x4.csv')).for(:csv) }

    it { should_not allow_value(csv_upload('5x3.csv')).for(:csv) }

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

    it { should allow_value(csv_upload('5x3.csv')).for(:csv) }

    it { should_not allow_value(csv_upload('6x4.csv')).for(:csv) }

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

    it { should allow_value(csv_upload('6x4.csv')).for(:csv) }

    it { should_not allow_value(csv_upload('5x3.csv')).for(:csv) }

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

    it { should allow_value(csv_upload('6x4.csv')).for(:csv) }

    it { should_not allow_value(csv_upload('5x3.csv')).for(:csv) }

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

    it { should allow_value(csv_upload('5x3.csv')).for(:csv) }

    it { should_not allow_value(csv_upload('6x4.csv')).for(:csv) }

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

    it { should allow_value(csv_upload('6x4.csv')).for(:csv) }

    it { should_not allow_value(csv_upload('5x3.csv')).for(:csv) }

    it { should ensure_valid_csv_format_of(:csv) }
    it { should_not ensure_valid_csv_format_of(:name) }
  end

end
