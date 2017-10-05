# frozen_string_literal: true

require 'spec_helper'

describe TypeValidator do

  context 'has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :title, :name
        validates :title, type: String
      end
    end

    subject { klass.new }

    it { should allow_value('Example').for(:title) }

    it { should_not allow_value(nil).for(:title) }
    it { should_not allow_value(123).for(:title) }
    it { should_not allow_value(true).for(:title) }
    it { should_not allow_value(false).for(:title) }

    it { should ensure_valid_type_format_of(:title) }
    it { should_not ensure_valid_type_format_of(:name) }
  end

  context 'has a valid boolean value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :title, :name
        validates :title, type: Boolean
      end
    end

    subject { klass.new }

    it { should allow_value(true).for(:title) }
    it { should allow_value(false).for(:title) }

    it { should_not allow_value('Example').for(:title) }
    it { should_not allow_value(nil).for(:title) }
    it { should_not allow_value(123).for(:title) }

    it { should ensure_valid_type_format_of(:title) }
    it { should_not ensure_valid_type_format_of(:name) }
  end

end
