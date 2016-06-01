require "spec_helper"

describe AlphaValidator do

  context "has a valid value" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :title, :name
        validates :title, alpha: true
      end
    end

    subject { klass.new }

    it { should allow_value("Example").for(:title) }
    it { should allow_value("Example Title").for(:title) }

    it { should_not allow_value("").for(:title) }
    it { should_not allow_value(" ").for(:title) }
    it { should_not allow_value(nil).for(:title) }
    it { should_not allow_value("Example1").for(:title) }
    it { should_not allow_value("Example 1").for(:title) }
    it { should_not allow_value("Ex-ample1").for(:title) }
    it { should_not allow_value("! \#$%\`|").for(:title) }
    it { should_not allow_value("<>@[]\`|").for(:title) }

    it { should ensure_valid_alpha_format_of(:title) }
    it { should_not ensure_valid_alpha_format_of(:name) }
  end

  context "with :strict option has a valid value" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :title, :name
        validates :title, alpha: { strict: true }
      end
    end

    subject { klass.new }

    it { should allow_value("Example").for(:title) }

    it { should_not allow_value("").for(:title) }
    it { should_not allow_value(" ").for(:title) }
    it { should_not allow_value(nil).for(:title) }
    it { should_not allow_value("Example Title").for(:title) }
    it { should_not allow_value("Example 1").for(:title) }
    it { should_not allow_value("Example1").for(:title) }
    it { should_not allow_value("Ex-ample").for(:title) }
    it { should_not allow_value("Ex-ample1").for(:title) }
    it { should_not allow_value("! \#$%\`|").for(:title) }
    it { should_not allow_value("<>@[]\`|").for(:title) }

    it { should ensure_valid_alpha_format_of(:title) }
    it { should_not ensure_valid_alpha_format_of(:name) }
  end

  context "with case: :lower option has a valid value" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :title, :name
        validates :title, alpha: { case: :lower }
      end
    end

    subject { klass.new }

    it { should allow_value("example").for(:title) }
    it { should allow_value("example title").for(:title) }

    it { should_not allow_value("").for(:title) }
    it { should_not allow_value(" ").for(:title) }
    it { should_not allow_value(nil).for(:title) }
    it { should_not allow_value("Example").for(:title) }
    it { should_not allow_value("Example Title").for(:title) }
    it { should_not allow_value("Example 1").for(:title) }
    it { should_not allow_value("Example1").for(:title) }
    it { should_not allow_value("Ex-ample").for(:title) }
    it { should_not allow_value("Ex-ample1").for(:title) }
    it { should_not allow_value("! \#$%\`|").for(:title) }
    it { should_not allow_value("<>@[]\`|").for(:title) }

    it { should ensure_valid_alpha_format_of(:title) }
    it { should_not ensure_valid_alpha_format_of(:name) }
  end

  context "with case: :upper option has a valid value" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :title, :name
        validates :title, alpha: { case: :upper }
      end
    end

    subject { klass.new }

    it { should allow_value("EXAMPLE").for(:title) }
    it { should allow_value("EXAMPLE TITLE").for(:title) }

    it { should_not allow_value("").for(:title) }
    it { should_not allow_value(" ").for(:title) }
    it { should_not allow_value(nil).for(:title) }
    it { should_not allow_value("example").for(:title) }
    it { should_not allow_value("Example").for(:title) }
    it { should_not allow_value("Example Title").for(:title) }
    it { should_not allow_value("Example 1").for(:title) }
    it { should_not allow_value("Example1").for(:title) }
    it { should_not allow_value("Ex-ample").for(:title) }
    it { should_not allow_value("Ex-ample1").for(:title) }
    it { should_not allow_value("! \#$%\`|").for(:title) }
    it { should_not allow_value("<>@[]\`|").for(:title) }

    it { should ensure_valid_alpha_format_of(:title) }
    it { should_not ensure_valid_alpha_format_of(:name) }
  end

  context "with case: :lower and :strict option has a valid value" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :title, :name
        validates :title, alpha: { case: :lower, strict: true }
      end
    end

    subject { klass.new }

    it { should allow_value("example").for(:title) }

    it { should_not allow_value("").for(:title) }
    it { should_not allow_value(" ").for(:title) }
    it { should_not allow_value(nil).for(:title) }
    it { should_not allow_value("Example").for(:title) }
    it { should_not allow_value("Example Title").for(:title) }
    it { should_not allow_value("Example 1").for(:title) }
    it { should_not allow_value("Example1").for(:title) }
    it { should_not allow_value("Ex-ample").for(:title) }
    it { should_not allow_value("Ex-ample1").for(:title) }
    it { should_not allow_value("example title").for(:title) }
    it { should_not allow_value("! \#$%\`|").for(:title) }
    it { should_not allow_value("<>@[]\`|").for(:title) }

    it { should ensure_valid_alpha_format_of(:title) }
    it { should_not ensure_valid_alpha_format_of(:name) }
  end

  context "with case: :upper and :strict option has a valid value" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :title, :name
        validates :title, alpha: { case: :upper, strict: true }
      end
    end

    subject { klass.new }

    it { should allow_value("EXAMPLE").for(:title) }

    it { should_not allow_value("").for(:title) }
    it { should_not allow_value(" ").for(:title) }
    it { should_not allow_value(nil).for(:title) }
    it { should_not allow_value("example").for(:title) }
    it { should_not allow_value("Example").for(:title) }
    it { should_not allow_value("Example Title").for(:title) }
    it { should_not allow_value("Example 1").for(:title) }
    it { should_not allow_value("Example1").for(:title) }
    it { should_not allow_value("Ex-ample").for(:title) }
    it { should_not allow_value("Ex-ample1").for(:title) }
    it { should_not allow_value("EXAMPLE TITLE").for(:title) }
    it { should_not allow_value("! \#$%\`|").for(:title) }
    it { should_not allow_value("<>@[]\`|").for(:title) }

    it { should ensure_valid_alpha_format_of(:title) }
    it { should_not ensure_valid_alpha_format_of(:name) }
  end

end
