require "spec_helper"

describe IpValidator do

  context "has a valid value" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :ip, :name
        validates :ip, ip: true
      end
    end

    subject { klass.new }

    it { should allow_value("0.0.0.0").for(:ip) }
    it { should allow_value("127.0.0.1").for(:ip) }
    it { should allow_value("99.39.240.31").for(:ip) }

    it { should_not allow_value("").for(:ip) }
    it { should_not allow_value(" ").for(:ip) }
    it { should_not allow_value(nil).for(:ip) }
    it { should_not allow_value("0 0 0 0").for(:ip) }
    it { should_not allow_value("0.0.0.0:3000").for(:ip) }
    it { should_not allow_value("22.22.333.22").for(:ip) }
    it { should_not allow_value("! \#$%\`|").for(:ip) }
    it { should_not allow_value("<>@[]\`|").for(:ip) }

    it { should ensure_valid_ip_format_of(:ip) }
    it { should_not ensure_valid_ip_format_of(:name) }
  end

end
