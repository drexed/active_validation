require 'spec_helper'

describe CoordinateValidator do

  context 'has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :coor, :lat, :lon, :name
        validates :coor, coordinate: true
        validates :lat,  coordinate: { boundary: :latitude }
        validates :lon,  coordinate: { boundary: :longitude }
      end
    end

    subject { klass.new }

    it { should allow_value(-90).for(:lat) }
    it { should allow_value(90).for(:lat) }
    it { should allow_value(0).for(:lat) }
    it { should allow_value(9.33).for(:lat) }
    it { should allow_value(-180).for(:lon) }
    it { should allow_value(180).for(:lon) }
    it { should allow_value(0).for(:lon) }
    it { should allow_value(9.33).for(:lon) }
    it { should allow_value([-90, -180]).for(:coor) }
    it { should allow_value([90, 180]).for(:coor) }
    it { should allow_value([0, 0]).for(:coor) }
    it { should allow_value([9.33, 9.33]).for(:coor) }

    it { should_not allow_value('').for(:lat) }
    it { should_not allow_value(' ').for(:lat) }
    it { should_not allow_value(nil).for(:lat) }
    it { should_not allow_value(-90.1).for(:lat) }
    it { should_not allow_value(90.1).for(:lat) }
    it { should_not allow_value('').for(:lon) }
    it { should_not allow_value(' ').for(:lon) }
    it { should_not allow_value(nil).for(:lon) }
    it { should_not allow_value(-180.1).for(:lon) }
    it { should_not allow_value(180.1).for(:lon) }
    it { should_not allow_value('').for(:coor) }
    it { should_not allow_value(' ').for(:coor) }
    it { should_not allow_value(nil).for(:coor) }
    it { should_not allow_value([]).for(:coor) }
    it { should_not allow_value([-90.1, -180.1]).for(:coor) }
    it { should_not allow_value([90.1, 180.1]).for(:coor) }

    it { should ensure_valid_coordinate_format_of(:coor) }
    it { should_not ensure_valid_coordinate_format_of(:name) }
  end

end
