require "spec_helper"

describe UuidValidator do

  context "has a valid value" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :uuid, :name
        validates :uuid, uuid: true
      end
    end

    subject { klass.new }

    it { should allow_value("6fa459ea-ee8a-3ca4-894e-db77e160355e").for(:uuid) }
    it { should allow_value("16fd2706-8baf-433b-82eb-8c7fada847da").for(:uuid) }
    it { should allow_value("886313e1-3b8a-5372-9b90-0c9aee199e5d").for(:uuid) }
    it { should allow_value("a8098c1a-f86e-11da-bd1a-00112444be1e").for(:uuid) }

    it { should_not allow_value("").for(:uuid) }
    it { should_not allow_value(" ").for(:uuid) }
    it { should_not allow_value(nil).for(:uuid) }
    it { should_not allow_value("6fa459ea-ee8a-3ca4-894e-db77e160355e1").for(:uuid) }
    it { should_not allow_value("16fd2706-8baf-433b-82eb-8c7fada847da1").for(:uuid) }
    it { should_not allow_value("886313e1-3b8a-5372-9b90-0c9aee199e5d1").for(:uuid) }
    it { should_not allow_value("a8098c1a-f86e-11da-bd1a-00112444be1e1").for(:uuid) }
    it { should_not allow_value("6fa459ea-ee8a-3ca4-894e-db77e160355").for(:uuid) }
    it { should_not allow_value("16fd2706-8baf-433b-82eb-8c7fada847d").for(:uuid) }
    it { should_not allow_value("886313e1-3b8a-5372-9b90-0c9aee199e5").for(:uuid) }
    it { should_not allow_value("a8098c1a-f86e-11da-bd1a-00112444be1").for(:uuid) }
    it { should_not allow_value("6fa459eaee8a3ca4894edb77e160355e").for(:uuid) }
    it { should_not allow_value("16fd27068baf433b82eb8c7fada847da").for(:uuid) }
    it { should_not allow_value("886313e13b8a53729b900c9aee199e5d").for(:uuid) }
    it { should_not allow_value("a8098c1af86e11dabd1a00112444be1e").for(:uuid) }
    it { should_not allow_value("! \#$%\`|").for(:uuid) }
    it { should_not allow_value("<>@[]\`|").for(:uuid) }

    it { should ensure_valid_uuid_format_of(:uuid) }
    it { should_not ensure_valid_uuid_format_of(:name) }
  end

  context "with version: 3 option has a valid value" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :uuid, :name
        validates :uuid, uuid: { version: 3 }
      end
    end

    subject { klass.new }

    it { should allow_value("6fa459ea-ee8a-3ca4-894e-db77e160355e").for(:uuid) }

    it { should_not allow_value("").for(:uuid) }
    it { should_not allow_value(" ").for(:uuid) }
    it { should_not allow_value(nil).for(:uuid) }
    it { should_not allow_value("16fd2706-8baf-433b-82eb-8c7fada847da").for(:uuid) }
    it { should_not allow_value("886313e1-3b8a-5372-9b90-0c9aee199e5d").for(:uuid) }
    it { should_not allow_value("a8098c1a-f86e-11da-bd1a-00112444be1e").for(:uuid) }
    it { should_not allow_value("6fa459ea-ee8a-3ca4-894e-db77e160355e1").for(:uuid) }
    it { should_not allow_value("16fd2706-8baf-433b-82eb-8c7fada847da1").for(:uuid) }
    it { should_not allow_value("886313e1-3b8a-5372-9b90-0c9aee199e5d1").for(:uuid) }
    it { should_not allow_value("a8098c1a-f86e-11da-bd1a-00112444be1e1").for(:uuid) }
    it { should_not allow_value("6fa459ea-ee8a-3ca4-894e-db77e160355").for(:uuid) }
    it { should_not allow_value("16fd2706-8baf-433b-82eb-8c7fada847d").for(:uuid) }
    it { should_not allow_value("886313e1-3b8a-5372-9b90-0c9aee199e5").for(:uuid) }
    it { should_not allow_value("a8098c1a-f86e-11da-bd1a-00112444be1").for(:uuid) }
    it { should_not allow_value("6fa459eaee8a3ca4894edb77e160355e").for(:uuid) }
    it { should_not allow_value("16fd27068baf433b82eb8c7fada847da").for(:uuid) }
    it { should_not allow_value("886313e13b8a53729b900c9aee199e5d").for(:uuid) }
    it { should_not allow_value("a8098c1af86e11dabd1a00112444be1e").for(:uuid) }
    it { should_not allow_value("! \#$%\`|").for(:uuid) }
    it { should_not allow_value("<>@[]\`|").for(:uuid) }

    it { should ensure_valid_uuid_format_of(:uuid) }
    it { should_not ensure_valid_uuid_format_of(:name) }
  end

  context "with version: 4 option has a valid value" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :uuid, :name
        validates :uuid, uuid: { version: 4 }
      end
    end

    subject { klass.new }

    it { should allow_value("16fd2706-8baf-433b-82eb-8c7fada847da").for(:uuid) }

    it { should_not allow_value("").for(:uuid) }
    it { should_not allow_value(" ").for(:uuid) }
    it { should_not allow_value(nil).for(:uuid) }
    it { should_not allow_value("6fa459ea-ee8a-3ca4-894e-db77e160355e").for(:uuid) }
    it { should_not allow_value("886313e1-3b8a-5372-9b90-0c9aee199e5d").for(:uuid) }
    it { should_not allow_value("a8098c1a-f86e-11da-bd1a-00112444be1e").for(:uuid) }
    it { should_not allow_value("6fa459ea-ee8a-3ca4-894e-db77e160355e1").for(:uuid) }
    it { should_not allow_value("16fd2706-8baf-433b-82eb-8c7fada847da1").for(:uuid) }
    it { should_not allow_value("886313e1-3b8a-5372-9b90-0c9aee199e5d1").for(:uuid) }
    it { should_not allow_value("a8098c1a-f86e-11da-bd1a-00112444be1e1").for(:uuid) }
    it { should_not allow_value("6fa459ea-ee8a-3ca4-894e-db77e160355").for(:uuid) }
    it { should_not allow_value("16fd2706-8baf-433b-82eb-8c7fada847d").for(:uuid) }
    it { should_not allow_value("886313e1-3b8a-5372-9b90-0c9aee199e5").for(:uuid) }
    it { should_not allow_value("a8098c1a-f86e-11da-bd1a-00112444be1").for(:uuid) }
    it { should_not allow_value("6fa459eaee8a3ca4894edb77e160355e").for(:uuid) }
    it { should_not allow_value("16fd27068baf433b82eb8c7fada847da").for(:uuid) }
    it { should_not allow_value("886313e13b8a53729b900c9aee199e5d").for(:uuid) }
    it { should_not allow_value("a8098c1af86e11dabd1a00112444be1e").for(:uuid) }
    it { should_not allow_value("! \#$%\`|").for(:uuid) }
    it { should_not allow_value("<>@[]\`|").for(:uuid) }

    it { should ensure_valid_uuid_format_of(:uuid) }
    it { should_not ensure_valid_uuid_format_of(:name) }
  end

  context "with version: 5 option has a valid value" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :uuid, :name
        validates :uuid, uuid: { version: 5 }
      end
    end

    subject { klass.new }

    it { should allow_value("886313e1-3b8a-5372-9b90-0c9aee199e5d").for(:uuid) }

    it { should_not allow_value("").for(:uuid) }
    it { should_not allow_value(" ").for(:uuid) }
    it { should_not allow_value(nil).for(:uuid) }
    it { should_not allow_value("6fa459ea-ee8a-3ca4-894e-db77e160355e").for(:uuid) }
    it { should_not allow_value("16fd2706-8baf-433b-82eb-8c7fada847da").for(:uuid) }
    it { should_not allow_value("a8098c1a-f86e-11da-bd1a-00112444be1e").for(:uuid) }
    it { should_not allow_value("6fa459ea-ee8a-3ca4-894e-db77e160355e1").for(:uuid) }
    it { should_not allow_value("16fd2706-8baf-433b-82eb-8c7fada847da1").for(:uuid) }
    it { should_not allow_value("886313e1-3b8a-5372-9b90-0c9aee199e5d1").for(:uuid) }
    it { should_not allow_value("a8098c1a-f86e-11da-bd1a-00112444be1e1").for(:uuid) }
    it { should_not allow_value("6fa459ea-ee8a-3ca4-894e-db77e160355").for(:uuid) }
    it { should_not allow_value("16fd2706-8baf-433b-82eb-8c7fada847d").for(:uuid) }
    it { should_not allow_value("886313e1-3b8a-5372-9b90-0c9aee199e5").for(:uuid) }
    it { should_not allow_value("a8098c1a-f86e-11da-bd1a-00112444be1").for(:uuid) }
    it { should_not allow_value("6fa459eaee8a3ca4894edb77e160355e").for(:uuid) }
    it { should_not allow_value("16fd27068baf433b82eb8c7fada847da").for(:uuid) }
    it { should_not allow_value("886313e13b8a53729b900c9aee199e5d").for(:uuid) }
    it { should_not allow_value("a8098c1af86e11dabd1a00112444be1e").for(:uuid) }
    it { should_not allow_value("! \#$%\`|").for(:uuid) }
    it { should_not allow_value("<>@[]\`|").for(:uuid) }

    it { should ensure_valid_uuid_format_of(:uuid) }
    it { should_not ensure_valid_uuid_format_of(:name) }
  end

end
