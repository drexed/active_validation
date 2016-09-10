require 'spec_helper'

describe PasswordValidator do

  context 'has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :password, :name
        validates :password, password: true
      end
    end

    subject { klass.new }

    it { should allow_value('password').for(:password) }
    it { should allow_value('Password').for(:password) }
    it { should allow_value('password1234').for(:password) }
    it { should allow_value('pa$$word').for(:password) }
    it { should allow_value('pass-word').for(:password) }
    it { should allow_value('pass_word').for(:password) }
    it { should allow_value('password!').for(:password) }
    it { should allow_value('password@').for(:password) }
    it { should allow_value('password#').for(:password) }
    it { should allow_value('password%').for(:password) }
    it { should allow_value('password^').for(:password) }
    it { should allow_value('password&').for(:password) }
    it { should allow_value('password*').for(:password) }

    it { should_not allow_value('').for(:password) }
    it { should_not allow_value(' ').for(:password) }
    it { should_not allow_value(nil).for(:password) }
    it { should_not allow_value(' password').for(:password) }
    it { should_not allow_value(' password ').for(:password) }
    it { should_not allow_value('password ').for(:password) }
    it { should_not allow_value('pass word').for(:password) }
    it { should_not allow_value('! \#$%\`|').for(:password) }
    it { should_not allow_value('<>@[]\`|').for(:password) }

    it { should ensure_valid_password_format_of(:password) }
    it { should_not ensure_valid_password_format_of(:name) }
  end

  context 'Password with :strict option has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :password, :name
        validates :password, password: { strict: true }
      end
    end

    subject { klass.new }

    it { should allow_value('Password123').for(:password) }
    it { should allow_value('Password-123').for(:password) }

    it { should_not allow_value('').for(:password) }
    it { should_not allow_value(' ').for(:password) }
    it { should_not allow_value(nil).for(:password) }
    it { should_not allow_value('pass').for(:password) }
    it { should_not allow_value(' password').for(:password) }
    it { should_not allow_value(' password ').for(:password) }
    it { should_not allow_value('password ').for(:password) }
    it { should_not allow_value('pass word').for(:password) }
    it { should_not allow_value('password-12345678910').for(:password) }
    it { should_not allow_value('password').for(:password) }
    it { should_not allow_value('password1234').for(:password) }
    it { should_not allow_value('pa$$word').for(:password) }
    it { should_not allow_value('pass-word').for(:password) }
    it { should_not allow_value('pass_word').for(:password) }
    it { should_not allow_value('password!').for(:password) }
    it { should_not allow_value('password@').for(:password) }
    it { should_not allow_value('password#').for(:password) }
    it { should_not allow_value('password%').for(:password) }
    it { should_not allow_value('password^').for(:password) }
    it { should_not allow_value('password&').for(:password) }
    it { should_not allow_value('password*').for(:password) }
    it { should_not allow_value('! \#$%\`|').for(:password) }
    it { should_not allow_value('<>@[]\`|').for(:password) }

    it { should ensure_valid_password_format_of(:password) }
    it { should_not ensure_valid_password_format_of(:name) }
  end

end
