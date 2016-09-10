require 'spec_helper'

describe IsinValidator do

  context 'has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :isin, :name
        validates :isin, isin: true
      end
    end

    subject { klass.new }

    it { should allow_value('US0378331005').for(:isin) }
    it { should allow_value('AU0000XVGZA3').for(:isin) }

    it { should_not allow_value('').for(:isin) }
    it { should_not allow_value(' ').for(:isin) }
    it { should_not allow_value(nil).for(:isin) }
    it { should_not allow_value('US03783310055').for(:isin) }
    it { should_not allow_value('US037833100').for(:isin) }
    it { should_not allow_value('US03783315').for(:isin) }
    it { should_not allow_value('AA0000XVGZA3').for(:isin) }
    it { should_not allow_value('120378331004').for(:isin) }
    it { should_not allow_value('! \#$%\`|').for(:isin) }
    it { should_not allow_value('<>@[]\`|').for(:isin) }

    it { should ensure_valid_isin_format_of(:isin) }
    it { should_not ensure_valid_isin_format_of(:name) }
  end

end
