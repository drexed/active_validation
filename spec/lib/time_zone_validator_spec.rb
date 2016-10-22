require 'spec_helper'

describe TimeZoneValidator do

  context 'has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :time_zone, :name
        validates :time_zone, time_zone: true
      end
    end

    subject { klass.new }

    it { should allow_value('America/New_York').for(:time_zone) }
    it { should allow_value('London').for(:time_zone) }

    it { should_not allow_value('').for(:time_zone) }
    it { should_not allow_value(' ').for(:time_zone) }
    it { should_not allow_value('! \#$%\`|').for(:time_zone) }
    it { should_not allow_value('<>@[]\`|').for(:time_zone) }
    it { should_not allow_value('America/Miami').for(:time_zone) }

    it { should ensure_valid_time_zone_format_of(:time_zone) }
    it { should_not ensure_valid_time_zone_format_of(:name) }
  end

end
