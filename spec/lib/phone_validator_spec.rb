require 'spec_helper'

describe PhoneValidator do

  context 'has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :phone, :name
        validates :phone, phone: true
      end
    end

    subject { klass.new }

    it { should allow_value('1234567').for(:phone) }
    it { should allow_value('123-4567').for(:phone) }
    it { should allow_value('123 4567').for(:phone) }
    it { should allow_value('5551234567').for(:phone) }
    it { should allow_value('555-123-4567').for(:phone) }
    it { should allow_value('555 123 4567').for(:phone) }
    it { should allow_value('(555) 123-4567').for(:phone) }
    it { should allow_value('(555) 123-4567 ext 1234').for(:phone) }
    it { should allow_value('(555) 123-4567 ext1234').for(:phone) }
    it { should allow_value('(555) 123-4567 ext-1234').for(:phone) }
    it { should allow_value('1-555-123-4567').for(:phone) }
    it { should allow_value('+1-555-123-4567').for(:phone) }
    it { should allow_value('+1 (555) 123-4567 ext-1234').for(:phone) }

    it { should_not allow_value('').for(:phone) }
    it { should_not allow_value(' ').for(:phone) }
    it { should_not allow_value(nil).for(:phone) }
    it { should_not allow_value('123_4567').for(:phone) }
    it { should_not allow_value('(555) 123-4567 ext:1234').for(:phone) }
    it { should_not allow_value('(555) 123-4567 ext_1234').for(:phone) }
    it { should_not allow_value('! \#$%\`|').for(:phone) }
    it { should_not allow_value('<>@[]\`|').for(:phone) }

    it { should ensure_valid_phone_format_of(:phone) }
    it { should_not ensure_valid_phone_format_of(:name) }
  end

end
