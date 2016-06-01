require "spec_helper"

describe CusipValidator do

  context "has a valid value" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :code, :name
        validates :code, cusip: true
      end
    end

    subject { klass.new }

    it { should allow_value("125509BG3").for(:code) }

    it { should_not allow_value("").for(:code) }
    it { should_not allow_value(" ").for(:code) }
    it { should_not allow_value(nil).for(:code) }
    it { should_not allow_value("12345678AB").for(:code) }

    it { should ensure_valid_cusip_format_of(:code) }
    it { should_not ensure_valid_cusip_format_of(:name) }
  end

end
