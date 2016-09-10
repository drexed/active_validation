require 'spec_helper'

describe HexValidator do

  context 'has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :color, :name
        validates :color, hex: true
      end
    end

    subject { klass.new }

    it { should allow_value('#aaa').for(:color) }
    it { should allow_value('#AAA').for(:color) }
    it { should allow_value('#aaaaaa').for(:color) }
    it { should allow_value('#AAAAAA').for(:color) }
    it { should allow_value('#999').for(:color) }
    it { should allow_value('#999999').for(:color) }
    it { should allow_value('#a9a').for(:color) }
    it { should allow_value('#A9A').for(:color) }
    it { should allow_value('#a9a9a9').for(:color) }
    it { should allow_value('#A9A9A9').for(:color) }
    it { should allow_value('aaa').for(:color) }
    it { should allow_value('AAA').for(:color) }
    it { should allow_value('aaaaaa').for(:color) }
    it { should allow_value('AAAAAA').for(:color) }
    it { should allow_value('999').for(:color) }
    it { should allow_value('999999').for(:color) }
    it { should allow_value('a9a').for(:color) }
    it { should allow_value('A9A').for(:color) }
    it { should allow_value('a9a9a9').for(:color) }
    it { should allow_value('A9A9A9').for(:color) }

    it { should_not allow_value('').for(:color) }
    it { should_not allow_value(' ').for(:color) }
    it { should_not allow_value(nil).for(:color) }
    it { should_not allow_value('#').for(:color) }
    it { should_not allow_value('#9').for(:color) }
    it { should_not allow_value('#9a').for(:color) }
    it { should_not allow_value('#9A').for(:color) }
    it { should_not allow_value('#hhh').for(:color) }
    it { should_not allow_value('#HHH').for(:color) }
    it { should_not allow_value('#9h9').for(:color) }
    it { should_not allow_value('#9H9').for(:color) }
    it { should_not allow_value('#9a9a').for(:color) }
    it { should_not allow_value('#9A9A').for(:color) }
    it { should_not allow_value('#9a9a9').for(:color) }
    it { should_not allow_value('#9A9A9').for(:color) }
    it { should_not allow_value('#9a9a9a9').for(:color) }
    it { should_not allow_value('#9A9A9A9').for(:color) }
    it { should_not allow_value(' #9a9').for(:color) }
    it { should_not allow_value(' #9A9').for(:color) }
    it { should_not allow_value(' #9a9 ').for(:color) }
    it { should_not allow_value(' #9A9 ').for(:color) }
    it { should_not allow_value('#9a9 ').for(:color) }
    it { should_not allow_value('#9A9 ').for(:color) }
    it { should_not allow_value(' 9a9').for(:color) }
    it { should_not allow_value(' 9A9').for(:color) }
    it { should_not allow_value(' 9a9 ').for(:color) }
    it { should_not allow_value(' 9A9 ').for(:color) }
    it { should_not allow_value('9a9 ').for(:color) }
    it { should_not allow_value('9A9 ').for(:color) }
    it { should_not allow_value('! \#$%\`|').for(:color) }
    it { should_not allow_value('<>@[]\`|').for(:color) }

    it { should ensure_valid_hex_format_of(:color) }
    it { should_not ensure_valid_hex_format_of(:name) }
  end

end
