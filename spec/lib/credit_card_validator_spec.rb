require 'spec_helper'

describe CreditCardValidator do

  context 'has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :cc_number, :name
        validates :cc_number, credit_card: true
      end
    end

    subject { klass.new }

    it { should allow_value('340000000000000').for(:cc_number) }
    it { should allow_value('370000000000000').for(:cc_number) }
    it { should allow_value('3700 0000.0000-000').for(:cc_number) }
    it { should allow_value('30000000000000').for(:cc_number) }
    it { should allow_value('30100000000000').for(:cc_number) }
    it { should allow_value('30200000000000').for(:cc_number) }
    it { should allow_value('30300000000000').for(:cc_number) }
    it { should allow_value('30400000000000').for(:cc_number) }
    it { should allow_value('30500000000000').for(:cc_number) }
    it { should allow_value('36000000000000').for(:cc_number) }
    it { should allow_value('54000000000000').for(:cc_number) }
    it { should allow_value('55000000000000').for(:cc_number) }
    it { should allow_value('5500000000000000').for(:cc_number) }
    it { should allow_value('5500 0000.0000-00').for(:cc_number) }
    it { should allow_value('5500 0000.0000-0000').for(:cc_number) }
    it { should allow_value('6011000000000000').for(:cc_number) }
    it { should allow_value('6221260000000000').for(:cc_number) }
    it { should allow_value('6221270000000000').for(:cc_number) }
    it { should allow_value('6221280000000000').for(:cc_number) }
    it { should allow_value('6221290000000000').for(:cc_number) }
    it { should allow_value('6221300000000000').for(:cc_number) }
    it { should allow_value('6221400000000000').for(:cc_number) }
    it { should allow_value('6221500000000000').for(:cc_number) }
    it { should allow_value('6221600000000000').for(:cc_number) }
    it { should allow_value('6221700000000000').for(:cc_number) }
    it { should allow_value('6221800000000000').for(:cc_number) }
    it { should allow_value('6221900000000000').for(:cc_number) }
    it { should allow_value('6222000000000000').for(:cc_number) }
    it { should allow_value('6223000000000000').for(:cc_number) }
    it { should allow_value('6224000000000000').for(:cc_number) }
    it { should allow_value('6225000000000000').for(:cc_number) }
    it { should allow_value('6226000000000000').for(:cc_number) }
    it { should allow_value('6227000000000000').for(:cc_number) }
    it { should allow_value('6228000000000000').for(:cc_number) }
    it { should allow_value('6229000000000000').for(:cc_number) }
    it { should allow_value('6229100000000000').for(:cc_number) }
    it { should allow_value('6229200000000000').for(:cc_number) }
    it { should allow_value('6229210000000000').for(:cc_number) }
    it { should allow_value('6229220000000000').for(:cc_number) }
    it { should allow_value('6229230000000000').for(:cc_number) }
    it { should allow_value('6229240000000000').for(:cc_number) }
    it { should allow_value('6229250000000000').for(:cc_number) }
    it { should allow_value('6440000000000000').for(:cc_number) }
    it { should allow_value('6450000000000000').for(:cc_number) }
    it { should allow_value('6460000000000000').for(:cc_number) }
    it { should allow_value('6470000000000000').for(:cc_number) }
    it { should allow_value('6480000000000000').for(:cc_number) }
    it { should allow_value('6490000000000000').for(:cc_number) }
    it { should allow_value('6500000000000000').for(:cc_number) }
    it { should allow_value('6500 0000.0000-0000').for(:cc_number) }
    it { should allow_value('3528000000000000').for(:cc_number) }
    it { should allow_value('3529000000000000').for(:cc_number) }
    it { should allow_value('3530000000000000').for(:cc_number) }
    it { should allow_value('3540000000000000').for(:cc_number) }
    it { should allow_value('3550000000000000').for(:cc_number) }
    it { should allow_value('3560000000000000').for(:cc_number) }
    it { should allow_value('3570000000000000').for(:cc_number) }
    it { should allow_value('3580000000000000').for(:cc_number) }
    it { should allow_value('3580 0000.0000-0000').for(:cc_number) }
    it { should allow_value('6304000000000000').for(:cc_number) }
    it { should allow_value('6706000000000000').for(:cc_number) }
    it { should allow_value('6771000000000000').for(:cc_number) }
    it { should allow_value('6709000000000000').for(:cc_number) }
    it { should allow_value('67090000000000000').for(:cc_number) }
    it { should allow_value('670900000000000000').for(:cc_number) }
    it { should allow_value('6709000000000000000').for(:cc_number) }
    it { should allow_value('6709 0000.0000-0000').for(:cc_number) }
    it { should allow_value('6709 0000.0000-00000').for(:cc_number) }
    it { should allow_value('6709 0000.0000-000000').for(:cc_number) }
    it { should allow_value('6709 0000.0000-0000000').for(:cc_number) }
    it { should allow_value('6221260000000000').for(:cc_number) }
    it { should allow_value('6221270000000000').for(:cc_number) }
    it { should allow_value('6221280000000000').for(:cc_number) }
    it { should allow_value('6221300000000000').for(:cc_number) }
    it { should allow_value('6221400000000000').for(:cc_number) }
    it { should allow_value('6221500000000000').for(:cc_number) }
    it { should allow_value('6221600000000000').for(:cc_number) }
    it { should allow_value('6221700000000000').for(:cc_number) }
    it { should allow_value('6221800000000000').for(:cc_number) }
    it { should allow_value('6221900000000000').for(:cc_number) }
    it { should allow_value('6222000000000000').for(:cc_number) }
    it { should allow_value('6223000000000000').for(:cc_number) }
    it { should allow_value('6224000000000000').for(:cc_number) }
    it { should allow_value('6225000000000000').for(:cc_number) }
    it { should allow_value('6226000000000000').for(:cc_number) }
    it { should allow_value('6227000000000000').for(:cc_number) }
    it { should allow_value('6228000000000000').for(:cc_number) }
    it { should allow_value('6229000000000000').for(:cc_number) }
    it { should allow_value('6229100000000000').for(:cc_number) }
    it { should allow_value('6229200000000000').for(:cc_number) }
    it { should allow_value('6229210000000000').for(:cc_number) }
    it { should allow_value('6229220000000000').for(:cc_number) }
    it { should allow_value('6229230000000000').for(:cc_number) }
    it { should allow_value('6229240000000000').for(:cc_number) }
    it { should allow_value('6229250000000000').for(:cc_number) }
    it { should allow_value('62292500000000000').for(:cc_number) }
    it { should allow_value('622925000000000000').for(:cc_number) }
    it { should allow_value('6229250000000000000').for(:cc_number) }
    it { should allow_value('6229 2500.0000-0000').for(:cc_number) }
    it { should allow_value('6229 2500.0000-00000').for(:cc_number) }
    it { should allow_value('6229 2500.0000-000000').for(:cc_number) }
    it { should allow_value('6229 2500.0000-0000000').for(:cc_number) }
    it { should allow_value('4000000000000000').for(:cc_number) }
    it { should allow_value('4000 0000.0000-0000').for(:cc_number) }

    it { should_not allow_value('').for(:cc_number) }
    it { should_not allow_value(' ').for(:cc_number) }
    it { should_not allow_value(nil).for(:cc_number) }
    it { should_not allow_value('#').for(:cc_number) }
    it { should_not allow_value('9').for(:cc_number) }
    it { should_not allow_value('a').for(:cc_number) }
    it { should_not allow_value('270000000000000').for(:cc_number) }
    it { should_not allow_value('37000000000000').for(:cc_number) }
    it { should_not allow_value('3700000000000000').for(:cc_number) }
    it { should_not allow_value('2700 0000.0000-000').for(:cc_number) }
    it { should_not allow_value('3700 0000.0000-00').for(:cc_number) }
    it { should_not allow_value('3700 0000.0000-0000').for(:cc_number) }
    it { should_not allow_value('5500000000000').for(:cc_number) }
    it { should_not allow_value('5500 0000.0000-0').for(:cc_number) }
    it { should_not allow_value('650000000000000').for(:cc_number) }
    it { should_not allow_value('65000000000000000').for(:cc_number) }
    it { should_not allow_value('6500 0000.0000-000').for(:cc_number) }
    it { should_not allow_value('6500 0000.0000-00000').for(:cc_number) }
    it { should_not allow_value('2580000000000000').for(:cc_number) }
    it { should_not allow_value('358000000000000').for(:cc_number) }
    it { should_not allow_value('35800000000000000').for(:cc_number) }
    it { should_not allow_value('2580 0000.0000-0000').for(:cc_number) }
    it { should_not allow_value('3580 0000.0000-000').for(:cc_number) }
    it { should_not allow_value('3580 0000.0000-00000').for(:cc_number) }
    it { should_not allow_value('5709000000000000').for(:cc_number) }
    it { should_not allow_value('670900000000000').for(:cc_number) }
    it { should_not allow_value('67090000000000000000').for(:cc_number) }
    it { should_not allow_value('5709 0000.0000-0000').for(:cc_number) }
    it { should_not allow_value('6709 0000.0000-000').for(:cc_number) }
    it { should_not allow_value('6709 0000.0000-00000000').for(:cc_number) }
    it { should_not allow_value('622925000000000').for(:cc_number) }
    it { should_not allow_value('62292500000000000000').for(:cc_number) }
    it { should_not allow_value('6229 2500.0000-000').for(:cc_number) }
    it { should_not allow_value('6229 2500.0000-00000000').for(:cc_number) }
    it { should_not allow_value('400000000000000').for(:cc_number) }
    it { should_not allow_value('40000000000000000').for(:cc_number) }
    it { should_not allow_value('4000 0000.0000-000').for(:cc_number) }
    it { should_not allow_value('4000 0000.0000-00000').for(:cc_number) }
    it { should_not allow_value('! \#$%\`|').for(:cc_number) }
    it { should_not allow_value('<>@[]\`|').for(:cc_number) }

    it { should ensure_valid_credit_card_format_of(:cc_number) }
    it { should_not ensure_valid_credit_card_format_of(:name) }
  end

  context 'with card: :american_express option has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :cc_number, :name
        validates :cc_number, credit_card: { card: :american_express }
      end
    end

    subject { klass.new }

    it { should allow_value('340000000000000').for(:cc_number) }
    it { should allow_value('370000000000000').for(:cc_number) }
    it { should allow_value('3700 0000.0000-000').for(:cc_number) }

    it { should_not allow_value('').for(:cc_number) }
    it { should_not allow_value(' ').for(:cc_number) }
    it { should_not allow_value(nil).for(:cc_number) }
    it { should_not allow_value('#').for(:cc_number) }
    it { should_not allow_value('9').for(:cc_number) }
    it { should_not allow_value('a').for(:cc_number) }
    it { should_not allow_value('270000000000000').for(:cc_number) }
    it { should_not allow_value('37000000000000').for(:cc_number) }
    it { should_not allow_value('3700000000000000').for(:cc_number) }
    it { should_not allow_value('2700 0000.0000-000').for(:cc_number) }
    it { should_not allow_value('3700 0000.0000-00').for(:cc_number) }
    it { should_not allow_value('3700 0000.0000-0000').for(:cc_number) }
    it { should_not allow_value('! \#$%\`|').for(:cc_number) }
    it { should_not allow_value('<>@[]\`|').for(:cc_number) }

    it { should ensure_valid_credit_card_format_of(:cc_number) }
    it { should_not ensure_valid_credit_card_format_of(:name) }
  end

  context 'with card: :diners_club option has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :cc_number, :name
        validates :cc_number, credit_card: { card: :diners_club }
      end
    end

    subject { klass.new }

    it { should allow_value('30000000000000').for(:cc_number) }
    it { should allow_value('30100000000000').for(:cc_number) }
    it { should allow_value('30200000000000').for(:cc_number) }
    it { should allow_value('30300000000000').for(:cc_number) }
    it { should allow_value('30400000000000').for(:cc_number) }
    it { should allow_value('30500000000000').for(:cc_number) }
    it { should allow_value('36000000000000').for(:cc_number) }
    it { should allow_value('54000000000000').for(:cc_number) }
    it { should allow_value('55000000000000').for(:cc_number) }
    it { should allow_value('5500000000000000').for(:cc_number) }
    it { should allow_value('5500 0000.0000-00').for(:cc_number) }
    it { should allow_value('5500 0000.0000-0000').for(:cc_number) }

    it { should_not allow_value('').for(:cc_number) }
    it { should_not allow_value(' ').for(:cc_number) }
    it { should_not allow_value(nil).for(:cc_number) }
    it { should_not allow_value('#').for(:cc_number) }
    it { should_not allow_value('9').for(:cc_number) }
    it { should_not allow_value('a').for(:cc_number) }
    it { should_not allow_value('4500000000000000').for(:cc_number) }
    it { should_not allow_value('5500000000000').for(:cc_number) }
    it { should_not allow_value('55000000000000000').for(:cc_number) }
    it { should_not allow_value('4500 0000.0000-0000').for(:cc_number) }
    it { should_not allow_value('5500 0000.0000-0').for(:cc_number) }
    it { should_not allow_value('5500 0000.0000-00000').for(:cc_number) }
    it { should_not allow_value('! \#$%\`|').for(:cc_number) }
    it { should_not allow_value('<>@[]\`|').for(:cc_number) }

    it { should ensure_valid_credit_card_format_of(:cc_number) }
    it { should_not ensure_valid_credit_card_format_of(:name) }
  end

  context 'with card: :discover option has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :cc_number, :name
        validates :cc_number, credit_card: { card: :discover }
      end
    end

    subject { klass.new }

    it { should allow_value('6011000000000000').for(:cc_number) }
    it { should allow_value('6221260000000000').for(:cc_number) }
    it { should allow_value('6221270000000000').for(:cc_number) }
    it { should allow_value('6221280000000000').for(:cc_number) }
    it { should allow_value('6221290000000000').for(:cc_number) }
    it { should allow_value('6221300000000000').for(:cc_number) }
    it { should allow_value('6221400000000000').for(:cc_number) }
    it { should allow_value('6221500000000000').for(:cc_number) }
    it { should allow_value('6221600000000000').for(:cc_number) }
    it { should allow_value('6221700000000000').for(:cc_number) }
    it { should allow_value('6221800000000000').for(:cc_number) }
    it { should allow_value('6221900000000000').for(:cc_number) }
    it { should allow_value('6222000000000000').for(:cc_number) }
    it { should allow_value('6223000000000000').for(:cc_number) }
    it { should allow_value('6224000000000000').for(:cc_number) }
    it { should allow_value('6225000000000000').for(:cc_number) }
    it { should allow_value('6226000000000000').for(:cc_number) }
    it { should allow_value('6227000000000000').for(:cc_number) }
    it { should allow_value('6228000000000000').for(:cc_number) }
    it { should allow_value('6229000000000000').for(:cc_number) }
    it { should allow_value('6229100000000000').for(:cc_number) }
    it { should allow_value('6229200000000000').for(:cc_number) }
    it { should allow_value('6229210000000000').for(:cc_number) }
    it { should allow_value('6229220000000000').for(:cc_number) }
    it { should allow_value('6229230000000000').for(:cc_number) }
    it { should allow_value('6229240000000000').for(:cc_number) }
    it { should allow_value('6229250000000000').for(:cc_number) }
    it { should allow_value('6440000000000000').for(:cc_number) }
    it { should allow_value('6450000000000000').for(:cc_number) }
    it { should allow_value('6460000000000000').for(:cc_number) }
    it { should allow_value('6470000000000000').for(:cc_number) }
    it { should allow_value('6480000000000000').for(:cc_number) }
    it { should allow_value('6490000000000000').for(:cc_number) }
    it { should allow_value('6500000000000000').for(:cc_number) }
    it { should allow_value('6500 0000.0000-0000').for(:cc_number) }

    it { should_not allow_value('').for(:cc_number) }
    it { should_not allow_value(' ').for(:cc_number) }
    it { should_not allow_value(nil).for(:cc_number) }
    it { should_not allow_value('#').for(:cc_number) }
    it { should_not allow_value('9').for(:cc_number) }
    it { should_not allow_value('a').for(:cc_number) }
    it { should_not allow_value('5500000000000000').for(:cc_number) }
    it { should_not allow_value('650000000000000').for(:cc_number) }
    it { should_not allow_value('65000000000000000').for(:cc_number) }
    it { should_not allow_value('5500 0000.0000-0000').for(:cc_number) }
    it { should_not allow_value('6500 0000.0000-000').for(:cc_number) }
    it { should_not allow_value('6500 0000.0000-00000').for(:cc_number) }
    it { should_not allow_value('! \#$%\`|').for(:cc_number) }
    it { should_not allow_value('<>@[]\`|').for(:cc_number) }

    it { should ensure_valid_credit_card_format_of(:cc_number) }
    it { should_not ensure_valid_credit_card_format_of(:name) }
  end

  context 'with card: :jcb option has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :cc_number, :name
        validates :cc_number, credit_card: { card: :jcb }
      end
    end

    subject { klass.new }

    it { should allow_value('3528000000000000').for(:cc_number) }
    it { should allow_value('3529000000000000').for(:cc_number) }
    it { should allow_value('3530000000000000').for(:cc_number) }
    it { should allow_value('3540000000000000').for(:cc_number) }
    it { should allow_value('3550000000000000').for(:cc_number) }
    it { should allow_value('3560000000000000').for(:cc_number) }
    it { should allow_value('3570000000000000').for(:cc_number) }
    it { should allow_value('3580000000000000').for(:cc_number) }
    it { should allow_value('3580 0000.0000-0000').for(:cc_number) }

    it { should_not allow_value('').for(:cc_number) }
    it { should_not allow_value(' ').for(:cc_number) }
    it { should_not allow_value(nil).for(:cc_number) }
    it { should_not allow_value('#').for(:cc_number) }
    it { should_not allow_value('9').for(:cc_number) }
    it { should_not allow_value('a').for(:cc_number) }
    it { should_not allow_value('2580000000000000').for(:cc_number) }
    it { should_not allow_value('358000000000000').for(:cc_number) }
    it { should_not allow_value('35800000000000000').for(:cc_number) }
    it { should_not allow_value('2580 0000.0000-0000').for(:cc_number) }
    it { should_not allow_value('3580 0000.0000-000').for(:cc_number) }
    it { should_not allow_value('3580 0000.0000-00000').for(:cc_number) }
    it { should_not allow_value('! \#$%\`|').for(:cc_number) }
    it { should_not allow_value('<>@[]\`|').for(:cc_number) }

    it { should ensure_valid_credit_card_format_of(:cc_number) }
    it { should_not ensure_valid_credit_card_format_of(:name) }
  end

  context 'with card: :laser option has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :cc_number, :name
        validates :cc_number, credit_card: { card: :laser }
      end
    end

    subject { klass.new }

    it { should allow_value('6304000000000000').for(:cc_number) }
    it { should allow_value('6706000000000000').for(:cc_number) }
    it { should allow_value('6771000000000000').for(:cc_number) }
    it { should allow_value('6709000000000000').for(:cc_number) }
    it { should allow_value('67090000000000000').for(:cc_number) }
    it { should allow_value('670900000000000000').for(:cc_number) }
    it { should allow_value('6709000000000000000').for(:cc_number) }
    it { should allow_value('6709 0000.0000-0000').for(:cc_number) }
    it { should allow_value('6709 0000.0000-00000').for(:cc_number) }
    it { should allow_value('6709 0000.0000-000000').for(:cc_number) }
    it { should allow_value('6709 0000.0000-0000000').for(:cc_number) }

    it { should_not allow_value('').for(:cc_number) }
    it { should_not allow_value(' ').for(:cc_number) }
    it { should_not allow_value(nil).for(:cc_number) }
    it { should_not allow_value('#').for(:cc_number) }
    it { should_not allow_value('9').for(:cc_number) }
    it { should_not allow_value('a').for(:cc_number) }
    it { should_not allow_value('5709000000000000').for(:cc_number) }
    it { should_not allow_value('670900000000000').for(:cc_number) }
    it { should_not allow_value('67090000000000000000').for(:cc_number) }
    it { should_not allow_value('5709 0000.0000-0000').for(:cc_number) }
    it { should_not allow_value('6709 0000.0000-000').for(:cc_number) }
    it { should_not allow_value('6709 0000.0000-00000000').for(:cc_number) }
    it { should_not allow_value('! \#$%\`|').for(:cc_number) }
    it { should_not allow_value('<>@[]\`|').for(:cc_number) }

    it { should ensure_valid_credit_card_format_of(:cc_number) }
    it { should_not ensure_valid_credit_card_format_of(:name) }
  end

  context 'with card: :maestro option has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :cc_number, :name
        validates :cc_number, credit_card: { card: :maestro }
      end
    end

    subject { klass.new }

    it { should allow_value('501800000000').for(:cc_number) }
    it { should allow_value('502000000000').for(:cc_number) }
    it { should allow_value('503800000000').for(:cc_number) }
    it { should allow_value('630400000000').for(:cc_number) }
    it { should allow_value('675900000000').for(:cc_number) }
    it { should allow_value('676100000000').for(:cc_number) }
    it { should allow_value('676200000000').for(:cc_number) }
    it { should allow_value('676300000000').for(:cc_number) }
    it { should allow_value('676400000000').for(:cc_number) }
    it { should allow_value('676500000000').for(:cc_number) }
    it { should allow_value('676600000000').for(:cc_number) }
    it { should allow_value('6766000000000').for(:cc_number) }
    it { should allow_value('67660000000000').for(:cc_number) }
    it { should allow_value('676600000000000').for(:cc_number) }
    it { should allow_value('6766000000000000').for(:cc_number) }
    it { should allow_value('67660000000000000').for(:cc_number) }
    it { should allow_value('676600000000000000').for(:cc_number) }
    it { should allow_value('6766000000000000000').for(:cc_number) }
    it { should allow_value('6766 0000.0000').for(:cc_number) }
    it { should allow_value('6766 0000.0000-0').for(:cc_number) }
    it { should allow_value('6766 0000.0000-00').for(:cc_number) }
    it { should allow_value('6766 0000.0000-000').for(:cc_number) }
    it { should allow_value('6766 0000.0000-0000').for(:cc_number) }
    it { should allow_value('6766 0000.0000-00000').for(:cc_number) }
    it { should allow_value('6766 0000.0000-000000').for(:cc_number) }
    it { should allow_value('6766 0000.0000-0000000').for(:cc_number) }

    it { should_not allow_value('').for(:cc_number) }
    it { should_not allow_value(' ').for(:cc_number) }
    it { should_not allow_value(nil).for(:cc_number) }
    it { should_not allow_value('#').for(:cc_number) }
    it { should_not allow_value('9').for(:cc_number) }
    it { should_not allow_value('a').for(:cc_number) }
    it { should_not allow_value('576600000000').for(:cc_number) }
    it { should_not allow_value('67660000000').for(:cc_number) }
    it { should_not allow_value('67660000000000000000').for(:cc_number) }
    it { should_not allow_value('5766 0000.0000').for(:cc_number) }
    it { should_not allow_value('6766 0000.000').for(:cc_number) }
    it { should_not allow_value('6766 0000.0000-00000000').for(:cc_number) }
    it { should_not allow_value('! \#$%\`|').for(:cc_number) }
    it { should_not allow_value('<>@[]\`|').for(:cc_number) }

    it { should ensure_valid_credit_card_format_of(:cc_number) }
    it { should_not ensure_valid_credit_card_format_of(:name) }
  end

  context 'with card: :mastercard option has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :cc_number, :name
        validates :cc_number, credit_card: { card: :mastercard }
      end
    end

    subject { klass.new }

    it { should allow_value('5100000000000000').for(:cc_number) }
    it { should allow_value('5200000000000000').for(:cc_number) }
    it { should allow_value('5300000000000000').for(:cc_number) }
    it { should allow_value('5400000000000000').for(:cc_number) }
    it { should allow_value('5500000000000000').for(:cc_number) }
    it { should allow_value('5500 0000.0000-0000').for(:cc_number) }

    it { should_not allow_value('').for(:cc_number) }
    it { should_not allow_value(' ').for(:cc_number) }
    it { should_not allow_value(nil).for(:cc_number) }
    it { should_not allow_value('#').for(:cc_number) }
    it { should_not allow_value('9').for(:cc_number) }
    it { should_not allow_value('a').for(:cc_number) }
    it { should_not allow_value('4500000000000000').for(:cc_number) }
    it { should_not allow_value('550000000000000').for(:cc_number) }
    it { should_not allow_value('55000000000000000').for(:cc_number) }
    it { should_not allow_value('4500 0000.0000-0000').for(:cc_number) }
    it { should_not allow_value('5500 0000.0000-00000').for(:cc_number) }
    it { should_not allow_value('5500 0000.0000-000').for(:cc_number) }
    it { should_not allow_value('! \#$%\`|').for(:cc_number) }
    it { should_not allow_value('<>@[]\`|').for(:cc_number) }

    it { should ensure_valid_credit_card_format_of(:cc_number) }
    it { should_not ensure_valid_credit_card_format_of(:name) }
  end

  context 'with card: :solo option has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :cc_number, :name
        validates :cc_number, credit_card: { card: :solo }
      end
    end

    subject { klass.new }

    it { should allow_value('6334000000000000').for(:cc_number) }
    it { should allow_value('6767000000000000').for(:cc_number) }
    it { should allow_value('676700000000000000').for(:cc_number) }
    it { should allow_value('6767000000000000000').for(:cc_number) }
    it { should allow_value('6767 0000.0000-0000').for(:cc_number) }
    it { should allow_value('6767 0000.0000-000000').for(:cc_number) }
    it { should allow_value('6767 0000.0000-0000000').for(:cc_number) }

    it { should_not allow_value('').for(:cc_number) }
    it { should_not allow_value(' ').for(:cc_number) }
    it { should_not allow_value(nil).for(:cc_number) }
    it { should_not allow_value('#').for(:cc_number) }
    it { should_not allow_value('9').for(:cc_number) }
    it { should_not allow_value('a').for(:cc_number) }
    it { should_not allow_value('5767000000000000').for(:cc_number) }
    it { should_not allow_value('676700000000000').for(:cc_number) }
    it { should_not allow_value('67670000000000000').for(:cc_number) }
    it { should_not allow_value('67670000000000000000').for(:cc_number) }
    it { should_not allow_value('5767 0000.0000-0000').for(:cc_number) }
    it { should_not allow_value('6767 0000.0000-000').for(:cc_number) }
    it { should_not allow_value('6767 0000.0000-00000').for(:cc_number) }
    it { should_not allow_value('6767 0000.0000-00000000').for(:cc_number) }
    it { should_not allow_value('! \#$%\`|').for(:cc_number) }
    it { should_not allow_value('<>@[]\`|').for(:cc_number) }

    it { should ensure_valid_credit_card_format_of(:cc_number) }
    it { should_not ensure_valid_credit_card_format_of(:name) }
  end

  context 'with card: :unionpay option has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :cc_number, :name
        validates :cc_number, credit_card: { card: :unionpay }
      end
    end

    subject { klass.new }

    it { should allow_value('6221260000000000').for(:cc_number) }
    it { should allow_value('6221270000000000').for(:cc_number) }
    it { should allow_value('6221280000000000').for(:cc_number) }
    it { should allow_value('6221300000000000').for(:cc_number) }
    it { should allow_value('6221400000000000').for(:cc_number) }
    it { should allow_value('6221500000000000').for(:cc_number) }
    it { should allow_value('6221600000000000').for(:cc_number) }
    it { should allow_value('6221700000000000').for(:cc_number) }
    it { should allow_value('6221800000000000').for(:cc_number) }
    it { should allow_value('6221900000000000').for(:cc_number) }
    it { should allow_value('6222000000000000').for(:cc_number) }
    it { should allow_value('6223000000000000').for(:cc_number) }
    it { should allow_value('6224000000000000').for(:cc_number) }
    it { should allow_value('6225000000000000').for(:cc_number) }
    it { should allow_value('6226000000000000').for(:cc_number) }
    it { should allow_value('6227000000000000').for(:cc_number) }
    it { should allow_value('6228000000000000').for(:cc_number) }
    it { should allow_value('6229000000000000').for(:cc_number) }
    it { should allow_value('6229100000000000').for(:cc_number) }
    it { should allow_value('6229200000000000').for(:cc_number) }
    it { should allow_value('6229210000000000').for(:cc_number) }
    it { should allow_value('6229220000000000').for(:cc_number) }
    it { should allow_value('6229230000000000').for(:cc_number) }
    it { should allow_value('6229240000000000').for(:cc_number) }
    it { should allow_value('6229250000000000').for(:cc_number) }
    it { should allow_value('62292500000000000').for(:cc_number) }
    it { should allow_value('622925000000000000').for(:cc_number) }
    it { should allow_value('6229250000000000000').for(:cc_number) }
    it { should allow_value('6229 2500.0000-0000').for(:cc_number) }
    it { should allow_value('6229 2500.0000-00000').for(:cc_number) }
    it { should allow_value('6229 2500.0000-000000').for(:cc_number) }
    it { should allow_value('6229 2500.0000-0000000').for(:cc_number) }

    it { should_not allow_value('').for(:cc_number) }
    it { should_not allow_value(' ').for(:cc_number) }
    it { should_not allow_value(nil).for(:cc_number) }
    it { should_not allow_value('#').for(:cc_number) }
    it { should_not allow_value('9').for(:cc_number) }
    it { should_not allow_value('a').for(:cc_number) }
    it { should_not allow_value('5229250000000000').for(:cc_number) }
    it { should_not allow_value('622925000000000').for(:cc_number) }
    it { should_not allow_value('62292500000000000000').for(:cc_number) }
    it { should_not allow_value('5229 2500.0000-0000').for(:cc_number) }
    it { should_not allow_value('6229 2500.0000-000').for(:cc_number) }
    it { should_not allow_value('6229 2500.0000-00000000').for(:cc_number) }
    it { should_not allow_value('! \#$%\`|').for(:cc_number) }
    it { should_not allow_value('<>@[]\`|').for(:cc_number) }

    it { should ensure_valid_credit_card_format_of(:cc_number) }
    it { should_not ensure_valid_credit_card_format_of(:name) }
  end

  context 'with card: :visa option has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :cc_number, :name
        validates :cc_number, credit_card: { card: :visa }
      end
    end

    subject { klass.new }

    it { should allow_value('4000000000000000').for(:cc_number) }
    it { should allow_value('4000 0000.0000-0000').for(:cc_number) }

    it { should_not allow_value('').for(:cc_number) }
    it { should_not allow_value(' ').for(:cc_number) }
    it { should_not allow_value(nil).for(:cc_number) }
    it { should_not allow_value('#').for(:cc_number) }
    it { should_not allow_value('9').for(:cc_number) }
    it { should_not allow_value('a').for(:cc_number) }
    it { should_not allow_value('3000000000000000').for(:cc_number) }
    it { should_not allow_value('400000000000000').for(:cc_number) }
    it { should_not allow_value('40000000000000000').for(:cc_number) }
    it { should_not allow_value('3000 0000.0000-0000').for(:cc_number) }
    it { should_not allow_value('4000 0000.0000-000').for(:cc_number) }
    it { should_not allow_value('4000 0000.0000-00000').for(:cc_number) }
    it { should_not allow_value('! \#$%\`|').for(:cc_number) }
    it { should_not allow_value('<>@[]\`|').for(:cc_number) }

    it { should ensure_valid_credit_card_format_of(:cc_number) }
    it { should_not ensure_valid_credit_card_format_of(:name) }
  end

  context 'with :strict option has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :cc_number, :name
        validates :cc_number, credit_card: { strict: true }
      end
    end

    subject { klass.new }

    it { should allow_value('4000000000000000').for(:cc_number) }

    it { should_not allow_value('').for(:cc_number) }
    it { should_not allow_value(' ').for(:cc_number) }
    it { should_not allow_value(nil).for(:cc_number) }
    it { should_not allow_value('#').for(:cc_number) }
    it { should_not allow_value('9').for(:cc_number) }
    it { should_not allow_value('a').for(:cc_number) }
    it { should_not allow_value('400000000000000').for(:cc_number) }
    it { should_not allow_value('40000000000000000').for(:cc_number) }
    it { should_not allow_value('3000 0000.0000-00').for(:cc_number) }
    it { should_not allow_value('4000 0000.0000-000').for(:cc_number) }
    it { should_not allow_value('4000 0000.0000-0000').for(:cc_number) }
    it { should_not allow_value('4000 0000.0000-00000').for(:cc_number) }
    it { should_not allow_value('! \#$%\`|').for(:cc_number) }
    it { should_not allow_value('<>@[]\`|').for(:cc_number) }

    it { should ensure_valid_credit_card_format_of(:cc_number) }
    it { should_not ensure_valid_credit_card_format_of(:name) }
  end

  context 'with card: :visa and :strict options has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :cc_number, :name
        validates :cc_number, credit_card: { card: :visa, strict: true }
      end
    end

    subject { klass.new }

    it { should allow_value('4000000000000000').for(:cc_number) }

    it { should_not allow_value('').for(:cc_number) }
    it { should_not allow_value(' ').for(:cc_number) }
    it { should_not allow_value(nil).for(:cc_number) }
    it { should_not allow_value('#').for(:cc_number) }
    it { should_not allow_value('9').for(:cc_number) }
    it { should_not allow_value('a').for(:cc_number) }
    it { should_not allow_value('3000000000000000').for(:cc_number) }
    it { should_not allow_value('400000000000000').for(:cc_number) }
    it { should_not allow_value('40000000000000000').for(:cc_number) }
    it { should_not allow_value('3000 0000.0000-0000').for(:cc_number) }
    it { should_not allow_value('4000 0000.0000-000').for(:cc_number) }
    it { should_not allow_value('4000 0000.0000-0000').for(:cc_number) }
    it { should_not allow_value('4000 0000.0000-00000').for(:cc_number) }
    it { should_not allow_value('! \#$%\`|').for(:cc_number) }
    it { should_not allow_value('<>@[]\`|').for(:cc_number) }

    it { should ensure_valid_credit_card_format_of(:cc_number) }
    it { should_not ensure_valid_credit_card_format_of(:name) }
  end

end
