require "spec_helper"

describe TrackingNumberValidator do

  context "has a valid value" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :tracking_number, :name
        validates :tracking_number, tracking_number: true
      end
    end

    subject { klass.new }

    it { should allow_value("3318810025").for(:tracking_number) }
    it { should allow_value("8487135506").for(:tracking_number) }
    it { should allow_value("3318810036").for(:tracking_number) }
    it { should allow_value("3318810014").for(:tracking_number) }
    it { should allow_value("73891051146").for(:tracking_number) }
    it { should allow_value("C11031500001879").for(:tracking_number) }
    it { should allow_value("C10999911320231").for(:tracking_number) }
    it { should allow_value("1Z5R89390357567127").for(:tracking_number) }
    it { should allow_value("1Z879E930346834440").for(:tracking_number) }
    it { should allow_value("1Z8V92A70367203024").for(:tracking_number) }
    it { should allow_value("1Z410E7W0392751591").for(:tracking_number) }
    it { should allow_value("RB123456785US").for(:tracking_number) }
    it { should allow_value("03071790000523483741").for(:tracking_number) }
    it { should allow_value("9101123456789000000013").for(:tracking_number) }
    it { should allow_value("71969010756003077385").for(:tracking_number) }
    it { should allow_value("9400111201080805483016").for(:tracking_number) }
    it { should allow_value("9505511069605048600624").for(:tracking_number) }
    it { should allow_value("9361289878700317633795").for(:tracking_number) }
    it { should allow_value("986578788855").for(:tracking_number) }
    it { should allow_value("477179081230").for(:tracking_number) }
    it { should allow_value("799531274483").for(:tracking_number) }
    it { should allow_value("790535312317").for(:tracking_number) }
    it { should allow_value("974367662710").for(:tracking_number) }
    it { should allow_value("041441760228964").for(:tracking_number) }
    it { should allow_value("568283610012000").for(:tracking_number) }
    it { should allow_value("568283610012734").for(:tracking_number) }
    it { should allow_value("000123450000000027").for(:tracking_number) }
    it { should allow_value("9611020987654312345672").for(:tracking_number) }
    it { should allow_value("61299998820821171811").for(:tracking_number) }
    it { should allow_value("9261292700768711948021").for(:tracking_number) }

    it { should_not allow_value("").for(:tracking_number) }
    it { should_not allow_value(" ").for(:tracking_number) }
    it { should_not allow_value(nil).for(:tracking_number) }
    it { should_not allow_value("3").for(:tracking_number) }
    it { should_not allow_value("C").for(:tracking_number) }
    it { should_not allow_value("3318810026").for(:tracking_number) }
    it { should_not allow_value(" 3318810026").for(:tracking_number) }
    it { should_not allow_value(" 3318810026 ").for(:tracking_number) }
    it { should_not allow_value("3318810026 ").for(:tracking_number) }
    it { should_not allow_value("33188 10026").for(:tracking_number) }
    it { should_not allow_value("C10999911320232").for(:tracking_number) }
    it { should_not allow_value(" C10999911320232").for(:tracking_number) }
    it { should_not allow_value(" C10999911320232 ").for(:tracking_number) }
    it { should_not allow_value("C10999911320232 ").for(:tracking_number) }
    it { should_not allow_value("C109999 11320232").for(:tracking_number) }
    it { should_not allow_value("1Z5R89390357567128").for(:tracking_number) }
    it { should_not allow_value(" 1Z5R89390357567127").for(:tracking_number) }
    it { should_not allow_value(" 1Z5R89390357567127 ").for(:tracking_number) }
    it { should_not allow_value("1Z5R89390357567127 ").for(:tracking_number) }
    it { should_not allow_value("1Z5R89390 357567127").for(:tracking_number) }
    it { should_not allow_value("RB123456780US").for(:tracking_number) }
    it { should_not allow_value("0307 1790 0005 2348 3741").for(:tracking_number) }
    it { should_not allow_value("9605511069605048600624").for(:tracking_number) }
    it { should_not allow_value("9361289878700317633796").for(:tracking_number) }
    it { should_not allow_value("9361 2898 7870 0317 6337 96").for(:tracking_number) }
    it { should_not allow_value("986578788856").for(:tracking_number) }
    it { should_not allow_value("041441760228965").for(:tracking_number) }
    it { should_not allow_value("0414 4176 0228 964").for(:tracking_number) }
    it { should_not allow_value("000123450000000026").for(:tracking_number) }
    it { should_not allow_value("00 0123 4500 0000 0027").for(:tracking_number) }
    it { should_not allow_value("9611020987654312345673").for(:tracking_number) }
    it { should_not allow_value("9261292700768711948022").for(:tracking_number) }
    it { should_not allow_value("! \#$%\`|").for(:tracking_number) }
    it { should_not allow_value("<>@[]\`|").for(:tracking_number) }

    it { should ensure_valid_tracking_number_format_of(:tracking_number) }
    it { should_not ensure_valid_tracking_number_format_of(:name) }
  end

  context "with carrier: :dhl option has a valid value" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :tracking_number, :name
        validates :tracking_number, tracking_number: { carrier: :dhl }
      end
    end

    subject { klass.new }

    it { should allow_value("3318810025").for(:tracking_number) }
    it { should allow_value("8487135506").for(:tracking_number) }
    it { should allow_value("3318810036").for(:tracking_number) }
    it { should allow_value("3318810014").for(:tracking_number) }
    it { should allow_value("73891051146").for(:tracking_number) }

    it { should_not allow_value("").for(:tracking_number) }
    it { should_not allow_value(" ").for(:tracking_number) }
    it { should_not allow_value(nil).for(:tracking_number) }
    it { should_not allow_value("3").for(:tracking_number) }
    it { should_not allow_value("3318810026").for(:tracking_number) }
    it { should_not allow_value(" 3318810026").for(:tracking_number) }
    it { should_not allow_value(" 3318810026 ").for(:tracking_number) }
    it { should_not allow_value("3318810026 ").for(:tracking_number) }
    it { should_not allow_value("33188 10026").for(:tracking_number) }
    it { should_not allow_value("! \#$%\`|").for(:tracking_number) }
    it { should_not allow_value("<>@[]\`|").for(:tracking_number) }

    it { should ensure_valid_tracking_number_format_of(:tracking_number) }
    it { should_not ensure_valid_tracking_number_format_of(:name) }
  end

  context "with carrier: :dhl and service: :express options has a valid value" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :tracking_number, :name
        validates :tracking_number, tracking_number: { carrier: :dhl, service: :express }
      end
    end

    subject { klass.new }

    it { should allow_value("3318810025").for(:tracking_number) }
    it { should allow_value("8487135506").for(:tracking_number) }
    it { should allow_value("3318810036").for(:tracking_number) }
    it { should allow_value("3318810014").for(:tracking_number) }

    it { should_not allow_value("").for(:tracking_number) }
    it { should_not allow_value(" ").for(:tracking_number) }
    it { should_not allow_value(nil).for(:tracking_number) }
    it { should_not allow_value("3").for(:tracking_number) }
    it { should_not allow_value("3318810026").for(:tracking_number) }
    it { should_not allow_value(" 3318810026").for(:tracking_number) }
    it { should_not allow_value(" 3318810026 ").for(:tracking_number) }
    it { should_not allow_value("3318810026 ").for(:tracking_number) }
    it { should_not allow_value("33188 10026").for(:tracking_number) }
    it { should_not allow_value("73891051146").for(:tracking_number) }
    it { should_not allow_value("! \#$%\`|").for(:tracking_number) }
    it { should_not allow_value("<>@[]\`|").for(:tracking_number) }

    it { should ensure_valid_tracking_number_format_of(:tracking_number) }
    it { should_not ensure_valid_tracking_number_format_of(:name) }
  end

  context "with carrier: :dhl and service: :express options has a valid value" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :tracking_number, :name
        validates :tracking_number, tracking_number: { carrier: :dhl, service: :express_air }
      end
    end

    subject { klass.new }

    it { should allow_value("73891051146").for(:tracking_number) }

    it { should_not allow_value("").for(:tracking_number) }
    it { should_not allow_value(" ").for(:tracking_number) }
    it { should_not allow_value(nil).for(:tracking_number) }
    it { should_not allow_value("3").for(:tracking_number) }
    it { should_not allow_value("3318810025").for(:tracking_number) }
    it { should_not allow_value("8487135506").for(:tracking_number) }
    it { should_not allow_value("3318810036").for(:tracking_number) }
    it { should_not allow_value("3318810014").for(:tracking_number) }
    it { should_not allow_value("3318810026").for(:tracking_number) }
    it { should_not allow_value(" 3318810026").for(:tracking_number) }
    it { should_not allow_value(" 3318810026 ").for(:tracking_number) }
    it { should_not allow_value("3318810026 ").for(:tracking_number) }
    it { should_not allow_value("33188 10026").for(:tracking_number) }
    it { should_not allow_value("! \#$%\`|").for(:tracking_number) }
    it { should_not allow_value("<>@[]\`|").for(:tracking_number) }

    it { should ensure_valid_tracking_number_format_of(:tracking_number) }
    it { should_not ensure_valid_tracking_number_format_of(:name) }
  end

  context "with carrier: :fedex option has a valid value" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :tracking_number, :name
        validates :tracking_number, tracking_number: { carrier: :fedex }
      end
    end

    subject { klass.new }

    it { should allow_value("986578788855").for(:tracking_number) }
    it { should allow_value("477179081230").for(:tracking_number) }
    it { should allow_value("799531274483").for(:tracking_number) }
    it { should allow_value("790535312317").for(:tracking_number) }
    it { should allow_value("974367662710").for(:tracking_number) }
    it { should allow_value("041441760228964").for(:tracking_number) }
    it { should allow_value("568283610012000").for(:tracking_number) }
    it { should allow_value("568283610012734").for(:tracking_number) }
    it { should allow_value("000123450000000027").for(:tracking_number) }
    it { should allow_value("9611020987654312345672").for(:tracking_number) }
    it { should allow_value("61299998820821171811").for(:tracking_number) }
    it { should allow_value("9261292700768711948021").for(:tracking_number) }

    it { should_not allow_value("").for(:tracking_number) }
    it { should_not allow_value(" ").for(:tracking_number) }
    it { should_not allow_value(nil).for(:tracking_number) }
    it { should_not allow_value("3").for(:tracking_number) }
    it { should_not allow_value("986578788856").for(:tracking_number) }
    it { should_not allow_value("041441760228965").for(:tracking_number) }
    it { should_not allow_value("0414 4176 0228 964").for(:tracking_number) }
    it { should_not allow_value("000123450000000026").for(:tracking_number) }
    it { should_not allow_value("00 0123 4500 0000 0027").for(:tracking_number) }
    it { should_not allow_value("9611020987654312345673").for(:tracking_number) }
    it { should_not allow_value("61299998820821171812").for(:tracking_number) }
    it { should_not allow_value("9261292700768711948022").for(:tracking_number) }
    it { should_not allow_value("! \#$%\`|").for(:tracking_number) }
    it { should_not allow_value("<>@[]\`|").for(:tracking_number) }

    it { should ensure_valid_tracking_number_format_of(:tracking_number) }
    it { should_not ensure_valid_tracking_number_format_of(:name) }
  end

  context "with carrier: :fedex and service: :express options has a valid value" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :tracking_number, :name
        validates :tracking_number, tracking_number: { carrier: :fedex, service: :express }
      end
    end

    subject { klass.new }

    it { should allow_value("986578788855").for(:tracking_number) }
    it { should allow_value("477179081230").for(:tracking_number) }
    it { should allow_value("799531274483").for(:tracking_number) }
    it { should allow_value("790535312317").for(:tracking_number) }
    it { should allow_value("974367662710").for(:tracking_number) }

    it { should_not allow_value("").for(:tracking_number) }
    it { should_not allow_value(" ").for(:tracking_number) }
    it { should_not allow_value(nil).for(:tracking_number) }
    it { should_not allow_value("3").for(:tracking_number) }
    it { should_not allow_value("986578788856").for(:tracking_number) }
    it { should_not allow_value("! \#$%\`|").for(:tracking_number) }
    it { should_not allow_value("<>@[]\`|").for(:tracking_number) }

    it { should ensure_valid_tracking_number_format_of(:tracking_number) }
    it { should_not ensure_valid_tracking_number_format_of(:name) }
  end

  context "with carrier: :fedex and service: :ground options has a valid value" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :tracking_number, :name
        validates :tracking_number, tracking_number: { carrier: :fedex, service: :ground }
      end
    end

    subject { klass.new }

    it { should allow_value("041441760228964").for(:tracking_number) }
    it { should allow_value("568283610012000").for(:tracking_number) }
    it { should allow_value("568283610012734").for(:tracking_number) }

    it { should_not allow_value("").for(:tracking_number) }
    it { should_not allow_value(" ").for(:tracking_number) }
    it { should_not allow_value(nil).for(:tracking_number) }
    it { should_not allow_value("3").for(:tracking_number) }
    it { should_not allow_value("041441760228965").for(:tracking_number) }
    it { should_not allow_value("0414 4176 0228 964").for(:tracking_number) }
    it { should_not allow_value("! \#$%\`|").for(:tracking_number) }
    it { should_not allow_value("<>@[]\`|").for(:tracking_number) }

    it { should ensure_valid_tracking_number_format_of(:tracking_number) }
    it { should_not ensure_valid_tracking_number_format_of(:name) }
  end

  context "with carrier: :fedex and service: :ground18 options has a valid value" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :tracking_number, :name
        validates :tracking_number, tracking_number: { carrier: :fedex, service: :ground18 }
      end
    end

    subject { klass.new }

    it { should allow_value("000123450000000027").for(:tracking_number) }

    it { should_not allow_value("").for(:tracking_number) }
    it { should_not allow_value(" ").for(:tracking_number) }
    it { should_not allow_value(nil).for(:tracking_number) }
    it { should_not allow_value("3").for(:tracking_number) }
    it { should_not allow_value("000123450000000026").for(:tracking_number) }
    it { should_not allow_value("00 0123 4500 0000 0027").for(:tracking_number) }
    it { should_not allow_value("! \#$%\`|").for(:tracking_number) }
    it { should_not allow_value("<>@[]\`|").for(:tracking_number) }

    it { should ensure_valid_tracking_number_format_of(:tracking_number) }
    it { should_not ensure_valid_tracking_number_format_of(:name) }
  end

  context "with carrier: :fedex and service: :ground96 options has a valid value" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :tracking_number, :name
        validates :tracking_number, tracking_number: { carrier: :fedex, service: :ground96 }
      end
    end

    subject { klass.new }

    it { should allow_value("9611020987654312345672").for(:tracking_number) }

    it { should_not allow_value("").for(:tracking_number) }
    it { should_not allow_value(" ").for(:tracking_number) }
    it { should_not allow_value(nil).for(:tracking_number) }
    it { should_not allow_value("3").for(:tracking_number) }
    it { should_not allow_value("9611020987654312345673").for(:tracking_number) }
    it { should_not allow_value("! \#$%\`|").for(:tracking_number) }
    it { should_not allow_value("<>@[]\`|").for(:tracking_number) }

    it { should ensure_valid_tracking_number_format_of(:tracking_number) }
    it { should_not ensure_valid_tracking_number_format_of(:name) }
  end

  context "with carrier: :fedex and service: :smart_post options has a valid value" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :tracking_number, :name
        validates :tracking_number, tracking_number: { carrier: :fedex, service: :smart_post }
      end
    end

    subject { klass.new }

    it { should allow_value("61299998820821171811").for(:tracking_number) }
    it { should allow_value("9261292700768711948021").for(:tracking_number) }

    it { should_not allow_value("").for(:tracking_number) }
    it { should_not allow_value(" ").for(:tracking_number) }
    it { should_not allow_value(nil).for(:tracking_number) }
    it { should_not allow_value("3").for(:tracking_number) }
    it { should_not allow_value("61299998820821171812").for(:tracking_number) }
    it { should_not allow_value("9261292700768711948022").for(:tracking_number) }
    it { should_not allow_value("! \#$%\`|").for(:tracking_number) }
    it { should_not allow_value("<>@[]\`|").for(:tracking_number) }

    it { should ensure_valid_tracking_number_format_of(:tracking_number) }
    it { should_not ensure_valid_tracking_number_format_of(:name) }
  end

  context "with carrier: :ontrac option has a valid value" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :tracking_number, :name
        validates :tracking_number, tracking_number: { carrier: :ontrac }
      end
    end

    subject { klass.new }

    it { should allow_value("C11031500001879").for(:tracking_number) }
    it { should allow_value("C10999911320231").for(:tracking_number) }

    it { should_not allow_value("").for(:tracking_number) }
    it { should_not allow_value(" ").for(:tracking_number) }
    it { should_not allow_value(nil).for(:tracking_number) }
    it { should_not allow_value("3").for(:tracking_number) }
    it { should_not allow_value("C").for(:tracking_number) }
    it { should_not allow_value("C10999911320232").for(:tracking_number) }
    it { should_not allow_value(" C10999911320232").for(:tracking_number) }
    it { should_not allow_value(" C10999911320232 ").for(:tracking_number) }
    it { should_not allow_value("C10999911320232 ").for(:tracking_number) }
    it { should_not allow_value("C109999 11320232").for(:tracking_number) }
    it { should_not allow_value("! \#$%\`|").for(:tracking_number) }
    it { should_not allow_value("<>@[]\`|").for(:tracking_number) }

    it { should ensure_valid_tracking_number_format_of(:tracking_number) }
    it { should_not ensure_valid_tracking_number_format_of(:name) }
  end

  context "with carrier: :ups option has a valid value" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :tracking_number, :name
        validates :tracking_number, tracking_number: { carrier: :ups }
      end
    end

    subject { klass.new }

    it { should allow_value("1Z5R89390357567127").for(:tracking_number) }
    it { should allow_value("1Z879E930346834440").for(:tracking_number) }
    it { should allow_value("1Z8V92A70367203024").for(:tracking_number) }
    it { should allow_value("1Z410E7W0392751591").for(:tracking_number) }

    it { should_not allow_value("").for(:tracking_number) }
    it { should_not allow_value(" ").for(:tracking_number) }
    it { should_not allow_value(nil).for(:tracking_number) }
    it { should_not allow_value("3").for(:tracking_number) }
    it { should_not allow_value("C").for(:tracking_number) }
    it { should_not allow_value("1Z5R89390357567128").for(:tracking_number) }
    it { should_not allow_value(" 1Z5R89390357567127").for(:tracking_number) }
    it { should_not allow_value(" 1Z5R89390357567127 ").for(:tracking_number) }
    it { should_not allow_value("1Z5R89390357567127 ").for(:tracking_number) }
    it { should_not allow_value("1Z5R89390 357567127").for(:tracking_number) }
    it { should_not allow_value("! \#$%\`|").for(:tracking_number) }
    it { should_not allow_value("<>@[]\`|").for(:tracking_number) }

    it { should ensure_valid_tracking_number_format_of(:tracking_number) }
    it { should_not ensure_valid_tracking_number_format_of(:name) }
  end

  context "with carrier: :usps option has a valid value" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :tracking_number, :name
        validates :tracking_number, tracking_number: { carrier: :usps }
      end
    end

    subject { klass.new }

    it { should allow_value("RB123456785US").for(:tracking_number) }
    it { should allow_value("03071790000523483741").for(:tracking_number) }
    it { should allow_value("9101123456789000000013").for(:tracking_number) }
    it { should allow_value("71969010756003077385").for(:tracking_number) }
    it { should allow_value("9400111201080805483016").for(:tracking_number) }
    it { should allow_value("9505511069605048600624").for(:tracking_number) }
    it { should allow_value("9361289878700317633795").for(:tracking_number) }

    it { should_not allow_value("").for(:tracking_number) }
    it { should_not allow_value(" ").for(:tracking_number) }
    it { should_not allow_value(nil).for(:tracking_number) }
    it { should_not allow_value("3").for(:tracking_number) }
    it { should_not allow_value("RB123456780US").for(:tracking_number) }
    it { should_not allow_value("03071790000523483742").for(:tracking_number) }
    it { should_not allow_value("0307 1790 0005 2348 3741").for(:tracking_number) }
    it { should_not allow_value("9605511069605048600624").for(:tracking_number) }
    it { should_not allow_value("9361289878700317633796").for(:tracking_number) }
    it { should_not allow_value("9361 2898 7870 0317 6337 96").for(:tracking_number) }
    it { should_not allow_value("! \#$%\`|").for(:tracking_number) }
    it { should_not allow_value("<>@[]\`|").for(:tracking_number) }

    it { should ensure_valid_tracking_number_format_of(:tracking_number) }
    it { should_not ensure_valid_tracking_number_format_of(:name) }
  end

  context "with carrier: :usps and service: :usps13 options has a valid value" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :tracking_number, :name
        validates :tracking_number, tracking_number: { carrier: :usps, service: :usps13 }
      end
    end

    subject { klass.new }

    it { should allow_value("RB123456785US").for(:tracking_number) }

    it { should_not allow_value("").for(:tracking_number) }
    it { should_not allow_value(" ").for(:tracking_number) }
    it { should_not allow_value(nil).for(:tracking_number) }
    it { should_not allow_value("3").for(:tracking_number) }
    it { should_not allow_value("RB123456780US").for(:tracking_number) }
    it { should_not allow_value("! \#$%\`|").for(:tracking_number) }
    it { should_not allow_value("<>@[]\`|").for(:tracking_number) }

    it { should ensure_valid_tracking_number_format_of(:tracking_number) }
    it { should_not ensure_valid_tracking_number_format_of(:name) }
  end

  context "with carrier: :usps and service: :usps20 options has a valid value" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :tracking_number, :name
        validates :tracking_number, tracking_number: { carrier: :usps, service: :usps20 }
      end
    end

    subject { klass.new }

    it { should allow_value("03071790000523483741").for(:tracking_number) }

    it { should_not allow_value("").for(:tracking_number) }
    it { should_not allow_value(" ").for(:tracking_number) }
    it { should_not allow_value(nil).for(:tracking_number) }
    it { should_not allow_value("3").for(:tracking_number) }
    it { should_not allow_value("03071790000523483742").for(:tracking_number) }
    it { should_not allow_value("0307 1790 0005 2348 3741").for(:tracking_number) }
    it { should_not allow_value("! \#$%\`|").for(:tracking_number) }
    it { should_not allow_value("<>@[]\`|").for(:tracking_number) }

    it { should ensure_valid_tracking_number_format_of(:tracking_number) }
    it { should_not ensure_valid_tracking_number_format_of(:name) }
  end

  context "with carrier: :usps and service: :usps91 options has a valid value" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :tracking_number, :name
        validates :tracking_number, tracking_number: { carrier: :usps, service: :usps91 }
      end
    end

    subject { klass.new }

    it { should allow_value("9101123456789000000013").for(:tracking_number) }
    it { should allow_value("71969010756003077385").for(:tracking_number) }
    it { should allow_value("9400111201080805483016").for(:tracking_number) }
    it { should allow_value("9505511069605048600624").for(:tracking_number) }
    it { should allow_value("9361289878700317633795").for(:tracking_number) }

    it { should_not allow_value("").for(:tracking_number) }
    it { should_not allow_value(" ").for(:tracking_number) }
    it { should_not allow_value(nil).for(:tracking_number) }
    it { should_not allow_value("3").for(:tracking_number) }
    it { should_not allow_value("9605511069605048600624").for(:tracking_number) }
    it { should_not allow_value("9361289878700317633796").for(:tracking_number) }
    it { should_not allow_value("9361 2898 7870 0317 6337 96").for(:tracking_number) }
    it { should_not allow_value("! \#$%\`|").for(:tracking_number) }
    it { should_not allow_value("<>@[]\`|").for(:tracking_number) }

    it { should ensure_valid_tracking_number_format_of(:tracking_number) }
    it { should_not ensure_valid_tracking_number_format_of(:name) }
  end

end
