require "spec_helper"

describe NameValidator do

  context "has a valid value" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :name, :email
        validates :name, name: true
      end
    end

    subject { klass.new }

    it { should allow_value("First Last").for(:name) }
    it { should allow_value("First Last-Name").for(:name) }
    it { should allow_value("First Middle Last").for(:name) }
    it { should allow_value("Sur First Middle Last").for(:name) }
    it { should allow_value("Sur First Middle Last Family").for(:name) }
    it { should allow_value("Sur First Middle Last-Family").for(:name) }

    it { should_not allow_value("").for(:name) }
    it { should_not allow_value(" ").for(:name) }
    it { should_not allow_value(nil).for(:name) }
    it { should_not allow_value("First").for(:name) }
    it { should_not allow_value("First Last_Name").for(:name) }
    it { should_not allow_value("First1 Last").for(:name) }
    it { should_not allow_value("First 1 Last").for(:name) }
    it { should_not allow_value("Sur. First Middle Last Jr.").for(:name) }
    it { should_not allow_value("Sur First Middle Last Family III").for(:name) }
    it { should_not allow_value("! \#$%\`|").for(:name) }
    it { should_not allow_value("<>@[]\`|").for(:name) }

    it { should ensure_valid_name_format_of(:name) }
    it { should_not ensure_valid_name_format_of(:email) }
  end

end
