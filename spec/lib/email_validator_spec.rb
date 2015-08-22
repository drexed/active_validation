require 'spec_helper'

describe EmailValidator do

  subject { klass.new }

  context "with valid format" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :email, :name
        validates :email, email: true
      end
    end

    it { should allow_value("s_u@example.com").for(:email) }
    it { should allow_value("super.user@example.com").for(:email) }
    it { should allow_value("super+user@example.com").for(:email) }
    it { should allow_value("super-user@example.com").for(:email) }
    it { should allow_value("super+user@example-site.com").for(:email) }
    it { should allow_value("user@example.com").for(:email) }
    it { should allow_value("user@example-site.com").for(:email) }
    it { should allow_value("user@en.example.com").for(:email) }
    it { should allow_value("user@example.museum").for(:email) }
    it { should allow_value("user@123.com").for(:email) }
    it { should allow_value("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ@example.com").for(:email) }
    it { should allow_value("01234567890@example.com").for(:email) }

    it { should_not allow_value("").for(:email) }
    it { should_not allow_value(" ").for(:email) }
    it { should_not allow_value(nil).for(:email) }
    it { should_not allow_value("example.com").for(:email) }
    it { should_not allow_value("super user@example.com").for(:email) }
    it { should_not allow_value(" user@example.com").for(:email) }
    it { should_not allow_value(" user@example.com ").for(:email) }
    it { should_not allow_value("user@example.com ").for(:email) }
    it { should_not allow_value("user").for(:email) }
    it { should_not allow_value("user@com").for(:email) }
    it { should_not allow_value("user@.com").for(:email) }
    it { should_not allow_value("user@example").for(:email) }
    it { should_not allow_value("user@example.").for(:email) }
    it { should_not allow_value("user@example.c").for(:email) }
    it { should_not allow_value("user_example.com").for(:email) }
    it { should_not allow_value("user@example_site.com").for(:email) }
    it { should_not allow_value("user@example.com@example.com").for(:email) }
    it { should_not allow_value("user@").for(:email) }
    it { should_not allow_value("user@! \"\#$%(),/;<>_[]\`|.com").for(:email) }
    it { should_not allow_value("user@127.0.0.1").for(:email) }
    it { should_not allow_value("user@127.0.0.1:25").for(:email) }
    it { should_not allow_value("user@example.com\n<script>alert('hello')</script>").for(:email) }
    it { should_not allow_value("@example.com").for(:email) }
    it { should_not allow_value("@example").for(:email) }
    it { should_not allow_value("@").for(:email) }
    it { should_not allow_value("! \#$%\`|@example.com").for(:email) }
    it { should_not allow_value("<>@[]\`|@example.com").for(:email) }

    it { should ensure_valid_email_format_of(:email) }
    it { should_not ensure_valid_email_format_of(:name) }
  end

  context "is in the specific domain" do
    context "domain specified as string" do
      let(:klass) do
        Class.new do
          include ActiveModel::Validations
          attr_accessor :email, :name
          validates :email, email: { domain: "edu" }
        end
      end

      it { should allow_value("user@example.edu").for(:email) }
      it { should_not allow_value("user@example.com").for(:email) }

      it { should ensure_valid_email_format_of(:email) }
      it { should_not ensure_valid_email_format_of(:name) }
    end

    context "set as an array of strings and symbols" do
      let(:klass) do
        Class.new do
          include ActiveModel::Validations
          attr_accessor :email, :name
          validates :email, email: { domain: ['com', :edu, 'Com.Au'] }
        end
      end

      it { should allow_value("user@example.com").for(:email) }
      it { should allow_value("user@example.edu").for(:email) }
      it { should allow_value("user@example.com.au").for(:email) }
      it { should allow_value("user@example.Com.Au").for(:email) }
      it { should_not allow_value("user@example.org").for(:email) }

      it { should ensure_valid_email_format_of(:email) }
      it { should_not ensure_valid_email_format_of(:name) }
    end
  end

end