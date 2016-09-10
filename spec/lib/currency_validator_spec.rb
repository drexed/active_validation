require 'spec_helper'

describe CurrencyValidator do

  context 'has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :price, :name
        validates :price, currency: true
      end
    end

    subject { klass.new }

    it { should allow_value('.00').for(:price) }
    it { should allow_value('1.0').for(:price) }
    it { should allow_value('1.00').for(:price) }
    it { should allow_value('12345678.00').for(:price) }

    it { should_not allow_value('').for(:price) }
    it { should_not allow_value(' ').for(:price) }
    it { should_not allow_value(nil).for(:price) }
    it { should_not allow_value('1').for(:price) }
    it { should_not allow_value('1.000').for(:price) }
    it { should_not allow_value('$1.00').for(:price) }
    it { should_not allow_value('! \#$%\`|').for(:price) }
    it { should_not allow_value('<>@[]\`|').for(:price) }

    it { should ensure_valid_currency_format_of(:price) }
    it { should_not ensure_valid_currency_format_of(:name) }
  end

  context 'with :strict option has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :price, :name
        validates :price, currency: { strict: true }
      end
    end

    subject { klass.new }

    it { should allow_value('1.00').for(:price) }
    it { should allow_value('12345678.00').for(:price) }

    it { should_not allow_value('').for(:price) }
    it { should_not allow_value(' ').for(:price) }
    it { should_not allow_value(nil).for(:price) }
    it { should_not allow_value('.00').for(:price) }
    it { should_not allow_value('1').for(:price) }
    it { should_not allow_value('1.0').for(:price) }
    it { should_not allow_value('1.000').for(:price) }
    it { should_not allow_value('$1.00').for(:price) }
    it { should_not allow_value('! \#$%\`|').for(:price) }
    it { should_not allow_value('<>@[]\`|').for(:price) }

    it { should ensure_valid_currency_format_of(:price) }
    it { should_not ensure_valid_currency_format_of(:name) }
  end

end
