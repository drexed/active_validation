require "spec_helper"

describe UsernameValidator do

  context "has a valid value" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :username, :name
        validates :username, username: true
      end
    end

    subject { klass.new }

    it { should allow_value("username").for(:username) }
    it { should allow_value("username123").for(:username) }
    it { should allow_value("username_123").for(:username) }
    it { should allow_value("username-123").for(:username) }

    it { should_not allow_value("").for(:username) }
    it { should_not allow_value(" ").for(:username) }
    it { should_not allow_value(nil).for(:username) }
    it { should_not allow_value("u").for(:username) }
    it { should_not allow_value(" username").for(:username) }
    it { should_not allow_value(" username ").for(:username) }
    it { should_not allow_value("username ").for(:username) }
    it { should_not allow_value("user name").for(:username) }
    it { should_not allow_value("username-123456789").for(:username) }
    it { should_not allow_value("! \#$%\`|").for(:username) }
    it { should_not allow_value("<>@[]\`|").for(:username) }

    it { should ensure_valid_username_format_of(:username) }
    it { should_not ensure_valid_username_format_of(:name) }
  end

end
