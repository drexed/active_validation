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
    it { should_not allow_value(txt_upload('csv.txt')).for(:csv) }

    # it { should ensure_valid_csv_format_of(:csv) }
    it { should_not ensure_valid_csv_format_of(:name) }
  end

  context 'with :columns_in option has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :csv, :name
        validates :csv, csv: { columns_in: (6..7) }
      end
    end

    subject { klass.new }

    it { should allow_value(csv_upload('6x4.csv')).for(:csv) }

    it { should_not allow_value(csv_upload('5x3.csv')).for(:csv) }

    # it { should ensure_valid_csv_format_of(:csv) }
    it { should_not ensure_valid_csv_format_of(:name) }
  end

  context 'with :columns_less_than option has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :csv, :name
        validates :csv, csv: { columns_less_than: 6 }
      end
    end

    subject { klass.new }

    it { should allow_value(csv_upload('5x3.csv')).for(:csv) }

    it { should_not allow_value(csv_upload('6x4.csv')).for(:csv) }

    # it { should ensure_valid_csv_format_of(:csv) }
    it { should_not ensure_valid_csv_format_of(:name) }
  end

  context 'with :columns_less_than_or_equal_to option has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :csv, :name
        validates :csv, csv: { columns_less_than_or_equal_to: 5 }
      end
    end

    subject { klass.new }

    it { should allow_value(csv_upload('5x3.csv')).for(:csv) }

    it { should_not allow_value(csv_upload('6x4.csv')).for(:csv) }

    # it { should ensure_valid_csv_format_of(:csv) }
    it { should_not ensure_valid_csv_format_of(:name) }
  end

  context 'with :columns_greater_than option has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :csv, :name
        validates :csv, csv: { columns_greater_than: 5 }
      end
    end

    subject { klass.new }

    it { should allow_value(csv_upload('6x4.csv')).for(:csv) }

    it { should_not allow_value(csv_upload('5x3.csv')).for(:csv) }

    # it { should ensure_valid_csv_format_of(:csv) }
    it { should_not ensure_valid_csv_format_of(:name) }
  end

  context 'with :columns_greater_than_or_equal_to option has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :csv, :name
        validates :csv, csv: { columns_greater_than_or_equal_to: 6 }
      end
    end

    subject { klass.new }

    it { should allow_value(csv_upload('6x4.csv')).for(:csv) }

    it { should_not allow_value(csv_upload('5x3.csv')).for(:csv) }

    # it { should ensure_valid_csv_format_of(:csv) }
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
    it { should_not allow_value(txt_upload('csv.txt')).for(:csv) }

    # it { should ensure_valid_csv_format_of(:csv) }
    it { should_not ensure_valid_csv_format_of(:name) }
  end

  context 'with :rows_in option has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :csv, :name
        validates :csv, csv: { rows_in: (4..7) }
      end
    end

    subject { klass.new }

    it { should allow_value(csv_upload('6x4.csv')).for(:csv) }

    it { should_not allow_value(csv_upload('5x3.csv')).for(:csv) }

    # it { should ensure_valid_csv_format_of(:csv) }
    it { should_not ensure_valid_csv_format_of(:name) }
  end

  context 'with :rows_less_than option has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :csv, :name
        validates :csv, csv: { rows_less_than: 4 }
      end
    end

    subject { klass.new }

    it { should allow_value(csv_upload('5x3.csv')).for(:csv) }

    it { should_not allow_value(csv_upload('6x4.csv')).for(:csv) }

    # it { should ensure_valid_csv_format_of(:csv) }
    it { should_not ensure_valid_csv_format_of(:name) }
  end

  context 'with :rows_less_than_or_equal_to option has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :csv, :name
        validates :csv, csv: { rows_less_than_or_equal_to: 3 }
      end
    end

    subject { klass.new }

    it { should allow_value(csv_upload('5x3.csv')).for(:csv) }

    it { should_not allow_value(csv_upload('6x4.csv')).for(:csv) }

    # it { should ensure_valid_csv_format_of(:csv) }
    it { should_not ensure_valid_csv_format_of(:name) }
  end

  context 'with :rows_greater_than option has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :csv, :name
        validates :csv, csv: { rows_greater_than: 3 }
      end
    end

    subject { klass.new }

    it { should allow_value(csv_upload('6x4.csv')).for(:csv) }

    it { should_not allow_value(csv_upload('5x3.csv')).for(:csv) }

    # it { should ensure_valid_csv_format_of(:csv) }
    it { should_not ensure_valid_csv_format_of(:name) }
  end

  context 'with :rows_greater_than_or_equal_to option has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :csv, :name
        validates :csv, csv: { rows_greater_than_or_equal_to: 4 }
      end
    end

    subject { klass.new }

    it { should allow_value(csv_upload('6x4.csv')).for(:csv) }

    it { should_not allow_value(csv_upload('5x3.csv')).for(:csv) }

    # it { should ensure_valid_csv_format_of(:csv) }
    it { should_not ensure_valid_csv_format_of(:name) }
  end

end
