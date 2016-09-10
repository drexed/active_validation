require 'spec_helper'

describe IsbnValidator do

  context 'has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :isbn, :name
        validates :isbn, isbn: true
      end
    end

    subject { klass.new }

    it { should allow_value('9519854894').for(:isbn) }
    it { should allow_value('951 98548 9 4').for(:isbn) }
    it { should allow_value('951-98548-9-4').for(:isbn) }
    it { should allow_value('951-98548 9 4').for(:isbn) }
    it { should allow_value('0-9722051-1-X').for(:isbn) }
    it { should allow_value('0-9722051-1-x').for(:isbn) }
    it { should allow_value('9781590599938').for(:isbn) }
    it { should allow_value('978 159059 9938').for(:isbn) }
    it { should allow_value('978-159059-9938').for(:isbn) }
    it { should allow_value('978-159059 9938').for(:isbn) }

    it { should_not allow_value('').for(:isbn) }
    it { should_not allow_value(' ').for(:isbn) }
    it { should_not allow_value(nil).for(:isbn) }
    it { should_not allow_value('951-98548-9-p').for(:isbn) }
    it { should_not allow_value('abc123ab3344').for(:isbn) }
    it { should_not allow_value('12345678901234').for(:isbn) }
    it { should_not allow_value('9991a9010599938').for(:isbn) }
    it { should_not allow_value('! \#$%\`|').for(:isbn) }
    it { should_not allow_value('<>@[]\`|').for(:isbn) }

    it { should ensure_valid_isbn_format_of(:isbn) }
    it { should_not ensure_valid_isbn_format_of(:name) }
  end

end
