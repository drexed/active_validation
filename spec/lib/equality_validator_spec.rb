# frozen_string_literal: true

require 'spec_helper'

describe EqualityValidator do

  context 'value less than' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :bid, :price, :name
        validates :bid, equality: { operator: :less_than, to: :price }
      end
    end

    subject(:model){ klass.new }

    specify 'first field less than the second' do
      model.bid = 1
      model.price = 2
      expect(model).to be_valid
    end

    specify 'first field equal to the second' do
      model.bid = 1
      model.price = 1
      expect(model).to be_invalid
    end

    specify 'first field greater than the second' do
      model.bid = 1
      model.price = 0
      expect(model).to be_invalid
    end

    specify 'first field is empty, the second is blank' do
      model.bid = ''
      model.price = ' '
      expect(model).to be_valid
    end

    specify 'first field is blank, the second is empty' do
      model.bid = ' '
      model.price = ''
      expect(model).to be_invalid
    end
  end

  context 'value less than or equal to' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :bid, :price, :name
        validates :bid, equality: { operator: :less_than_or_equal_to, to: :price }
      end
    end

    subject(:model){ klass.new }

    specify 'first field equal to the second' do
      model.bid = 1
      model.price = 1
      expect(model).to be_valid
    end

    specify 'first field less than the second' do
      model.bid = 1
      model.price = 2
      expect(model).to be_valid
    end

    specify 'first field greater than the second' do
      model.bid = 1
      model.price = 0
      expect(model).to be_invalid
    end

    specify 'first field is empty, the second is blank' do
      model.bid = ''
      model.price = ' '
      expect(model).to be_valid
    end

    specify 'first field is blank, the second is empty' do
      model.bid = ' '
      model.price = ''
      expect(model).to be_invalid
    end

    specify 'both fields are blank' do
      model.bid = model.price = ''
      expect(model).to be_valid
    end

    specify 'both fields are empty' do
      model.bid = model.price = ' '
      expect(model).to be_valid
    end
  end

  context 'value greater than' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :bid, :price, :name
        validates :bid, equality: { operator: :greater_than, to: :price }
      end
    end

    subject(:model){ klass.new }

    specify 'first field greater than the second' do
      model.bid = 1
      model.price = 0
      expect(model).to be_valid
    end

    specify 'first field less than the second' do
      model.bid = 1
      model.price = 2
      expect(model).to be_invalid
    end

    specify 'first field equal to the second' do
      model.bid = 1
      model.price = 1
      expect(model).to be_invalid
    end

    specify 'first field is empty, the second is blank' do
      model.bid = ''
      model.price = ' '
      expect(model).to be_invalid
    end

    specify 'first field is blank, the second is empty' do
      model.bid = ' '
      model.price = ''
      expect(model).to be_valid
    end
  end

  context 'value greater than or equal to' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :bid, :price, :name
        validates :bid, equality: { operator: :greater_than_or_equal_to, to: :price }
      end
    end

    subject(:model){ klass.new }

    specify 'first field equal to the second' do
      model.bid = 1
      model.price = 1
      expect(model).to be_valid
    end

    specify 'first field greater than the second' do
      model.bid = 1
      model.price = 0
      expect(model).to be_valid
    end

    specify 'first field less than the second' do
      model.bid = 1
      model.price = 2
      expect(model).to be_invalid
    end

    specify 'first field is empty, the second is blank' do
      model.bid = ''
      model.price = ' '
      expect(model).to be_invalid
    end

    specify 'first field is blank, the second is empty' do
      model.bid = ' '
      model.price = ''
      expect(model).to be_valid
    end

    specify 'both fields are blank' do
      model.bid = model.price = ''
      expect(model).to be_valid
    end

    specify 'both fields are empty' do
      model.bid = model.price = ' '
      expect(model).to be_valid
    end
  end

  context 'value equal to' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :bid, :price, :name
        validates :bid, equality: { operator: :equal_to, to: :price }
      end
    end

    subject(:model){ klass.new }

    specify 'first field equal to the second' do
      model.bid = 1
      model.price = 1
      expect(model).to be_valid
    end

    specify 'first field less than the second' do
      model.bid = 1
      model.price = 2
      expect(model).to be_invalid
    end

    specify 'first field greater than the second' do
      model.bid = 1
      model.price = 0
      expect(model).to be_invalid
    end

    specify 'first field has value, the second is nil' do
      model.bid = 1
      model.price = nil
      expect(model).to be_invalid
    end

    specify 'first field is nil, the second has value' do
      model.bid = nil
      model.price = 1
      expect(model).to be_invalid
    end

    specify 'both fields are nil' do
      model.bid = model.price = nil
      expect(model).to be_valid
    end

    specify 'first field is empty, the second is blank' do
      model.bid = ''
      model.price = ' '
      expect(model).to be_invalid
    end

    specify 'first field is blank, the second is empty' do
      model.bid = ' '
      model.price = ''
      expect(model).to be_invalid
    end

    specify 'both fields are blank' do
      model.bid = model.price = ''
      expect(model).to be_valid
    end

    specify 'both fields are empty' do
      model.bid = model.price = ' '
      expect(model).to be_valid
    end
  end

  context 'value not equal to' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :bid, :price, :name
        validates :bid, equality: { operator: :not_equal_to, to: :price }
      end
    end

    subject(:model){ klass.new }

    specify 'first field equal to the second' do
      model.bid = 1
      model.price = 1
      expect(model).to be_invalid
    end

    specify 'first field less than the second' do
      model.bid = 1
      model.price = 2
      expect(model).to be_valid
    end

    specify 'first field greater than the second' do
      model.bid = 1
      model.price = 0
      expect(model).to be_valid
    end

    specify 'first field has value, the second is nil' do
      model.bid = 1
      model.price = nil
      expect(model).to be_valid
    end

    specify 'first field is nil, the second has value' do
      model.bid = nil
      model.price = 1
      expect(model).to be_valid
    end

    specify 'both fields are nil' do
      model.bid = model.price = nil
      expect(model).to be_invalid
    end

    specify 'first field is empty, the second is blank' do
      model.bid = ''
      model.price = ' '
      expect(model).to be_valid
    end

    specify 'first field is blank, the second is empty' do
      model.bid = ' '
      model.price = ''
      expect(model).to be_valid
    end

    specify 'both fields are blank' do
      model.bid = model.price = ''
      expect(model).to be_invalid
    end

    specify 'both fields are empty' do
      model.bid = model.price = ' '
      expect(model).to be_invalid
    end
  end

  # it { should ensure_equality_of(:bid).to(:price).operator(:less_than) }
  # it { should_not ensure_equality_of(:bid).to(:name).operator(:less_than) }
end
