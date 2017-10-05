# frozen_string_literal: true

require 'spec_helper'

describe AlphaNumericValidator do

  context 'has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :title, :name
        validates :title, alpha_numeric: true
      end
    end

    subject { klass.new }

    it { should allow_value('Example').for(:title) }
    it { should allow_value('Example Title').for(:title) }
    it { should allow_value('Example1').for(:title) }
    it { should allow_value('Example 1').for(:title) }

    it { should_not allow_value('').for(:title) }
    it { should_not allow_value(' ').for(:title) }
    it { should_not allow_value(nil).for(:title) }
    it { should_not allow_value('Ex-ample').for(:title) }
    it { should_not allow_value('Ex-ample1').for(:title) }
    it { should_not allow_value('! \#$%\`|').for(:title) }
    it { should_not allow_value('<>@[]\`|').for(:title) }

    it { should ensure_valid_alpha_numeric_format_of(:title) }
    it { should_not ensure_valid_alpha_numeric_format_of(:name) }
  end

  context 'with :strict option has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :title, :name
        validates :title, alpha_numeric: { strict: true }
      end
    end

    subject { klass.new }

    it { should allow_value('Example').for(:title) }
    it { should allow_value('Example1').for(:title) }

    it { should_not allow_value('').for(:title) }
    it { should_not allow_value(' ').for(:title) }
    it { should_not allow_value(nil).for(:title) }
    it { should_not allow_value('Example Title').for(:title) }
    it { should_not allow_value('Example 1').for(:title) }
    it { should_not allow_value('Ex-ample').for(:title) }
    it { should_not allow_value('Ex-ample1').for(:title) }
    it { should_not allow_value('! \#$%\`|').for(:title) }
    it { should_not allow_value('<>@[]\`|').for(:title) }

    it { should ensure_valid_alpha_numeric_format_of(:title) }
    it { should_not ensure_valid_alpha_numeric_format_of(:name) }
  end

  context 'with case: :lower option has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :title, :name
        validates :title, alpha_numeric: { case: :lower }
      end
    end

    subject { klass.new }

    it { should allow_value('example1').for(:title) }
    it { should allow_value('example title 1').for(:title) }

    it { should_not allow_value('').for(:title) }
    it { should_not allow_value(' ').for(:title) }
    it { should_not allow_value(nil).for(:title) }
    it { should_not allow_value('Example').for(:title) }
    it { should_not allow_value('Example Title').for(:title) }
    it { should_not allow_value('Example 1').for(:title) }
    it { should_not allow_value('Example1').for(:title) }
    it { should_not allow_value('Ex-ample').for(:title) }
    it { should_not allow_value('Ex-ample1').for(:title) }
    it { should_not allow_value('! \#$%\`|').for(:title) }
    it { should_not allow_value('<>@[]\`|').for(:title) }

    it { should ensure_valid_alpha_numeric_format_of(:title) }
    it { should_not ensure_valid_alpha_numeric_format_of(:name) }
  end

end
