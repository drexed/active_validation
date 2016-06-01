require "spec_helper"

describe BooleanValidator do

  context "has a valid value" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :active, :name
        validates :active, boolean: true
      end
    end

    subject { klass.new }

    it { should allow_value(true).for(:active) }
    it { should allow_value(false).for(:active) }
    it { should allow_value("true").for(:active) }
    it { should allow_value("false").for(:active) }
    it { should allow_value(1).for(:active) }
    it { should allow_value(0).for(:active) }
    it { should allow_value("1").for(:active) }
    it { should allow_value("0").for(:active) }

    it { should_not allow_value("").for(:active) }
    it { should_not allow_value(" ").for(:active) }
    it { should_not allow_value(nil).for(:active) }
    it { should_not allow_value("! \#$%\`|").for(:active) }
    it { should_not allow_value("<>@[]\`|").for(:active) }

    it { should ensure_valid_boolean_format_of(:active) }
    it { should_not ensure_valid_boolean_format_of(:name) }
  end

end
