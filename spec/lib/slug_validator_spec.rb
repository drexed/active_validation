require 'spec_helper'

describe SlugValidator do

  context 'has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :slug, :name
        validates :slug, slug: true
      end
    end

    subject { klass.new }

    it { should allow_value('slug').for(:slug) }
    it { should allow_value('Slug').for(:slug) }
    it { should allow_value('slug1234').for(:slug) }
    it { should allow_value('slug-word').for(:slug) }
    it { should allow_value('slug-1234').for(:slug) }
    it { should allow_value('Slug-1234').for(:slug) }
    it { should allow_value('slug_word').for(:slug) }
    it { should allow_value('Slug_word').for(:slug) }
    it { should allow_value('slug_1234').for(:slug) }
    it { should allow_value('Slug_1234').for(:slug) }

    it { should_not allow_value('').for(:slug) }
    it { should_not allow_value(' ').for(:slug) }
    it { should_not allow_value(nil).for(:slug) }
    it { should_not allow_value(' slug').for(:slug) }
    it { should_not allow_value(' slug ').for(:slug) }
    it { should_not allow_value('slug ').for(:slug) }
    it { should_not allow_value(' 1234').for(:slug) }
    it { should_not allow_value(' 1234 ').for(:slug) }
    it { should_not allow_value('1234 ').for(:slug) }
    it { should_not allow_value('slug word').for(:slug) }
    it { should_not allow_value('slug 1234').for(:slug) }
    it { should_not allow_value('! \#$%\`|').for(:slug) }
    it { should_not allow_value('<>@[]\`|').for(:slug) }

    it { should ensure_valid_slug_format_of(:slug) }
    it { should_not ensure_valid_slug_format_of(:name) }
  end

end
