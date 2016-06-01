require "spec_helper"

describe SsnValidator do

  context "has a valid value" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :ssn, :name
        validates :ssn, ssn: true
      end
    end

    subject { klass.new }

    it { should allow_value("333-22-4444").for(:ssn) }
    it { should allow_value("333224444").for(:ssn) }

    it { should_not allow_value("").for(:ssn) }
    it { should_not allow_value(" ").for(:ssn) }
    it { should_not allow_value(nil).for(:ssn) }
    it { should_not allow_value(" 333-22-4444").for(:ssn) }
    it { should_not allow_value(" 333-22-4444 ").for(:ssn) }
    it { should_not allow_value("333-22-4444 ").for(:ssn) }
    it { should_not allow_value("333 22 4444").for(:ssn) }
    it { should_not allow_value("333-22-444n").for(:ssn) }
    it { should_not allow_value("333 22 4444").for(:ssn) }
    it { should_not allow_value("3-2-4").for(:ssn) }
    it { should_not allow_value("! \#$%\`|").for(:ssn) }
    it { should_not allow_value("<>@[]\`|").for(:ssn) }

    it { should ensure_valid_ssn_format_of(:ssn) }
    it { should_not ensure_valid_ssn_format_of(:name) }
  end

end
