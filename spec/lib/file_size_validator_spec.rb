require 'spec_helper'
require 'support/helpers/file_helper'

describe FileSizeValidator do
  include FileHelper

  context 'with :columns option has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :file, :name
        validates :file, file_size: { less_than: 100 }

        def self.name
          'Class'
        end
      end
    end

    subject { klass.new }

    it { should allow_value(csv_upload('5x3.csv')).for(:file) }

    it { should_not allow_value(txt_upload('csv.txt')).for(:file) }

    # it { should ensure_valid_csv_format_of(:file) }
    it { should_not ensure_valid_csv_format_of(:name) }
  end

end
