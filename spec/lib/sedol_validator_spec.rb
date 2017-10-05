# frozen_string_literal: true

require 'spec_helper'

describe SedolValidator do

  context 'has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :sedol, :name
        validates :sedol, sedol: true
      end
    end

    subject { klass.new }

    it { should allow_value('B0WNLY7').for(:sedol) }

    it { should_not allow_value('').for(:sedol) }
    it { should_not allow_value(' ').for(:sedol) }
    it { should_not allow_value(nil).for(:sedol) }
    it { should_not allow_value('B0WNL').for(:sedol) }
    it { should_not allow_value('B0WNLY').for(:sedol) }
    it { should_not allow_value('B0WNLY77').for(:sedol) }
    it { should_not allow_value('! \#$%\`|').for(:sedol) }
    it { should_not allow_value('<>@[]\`|').for(:sedol) }

    it { should ensure_valid_sedol_format_of(:sedol) }
    it { should_not ensure_valid_sedol_format_of(:name) }
  end

end
