# frozen_string_literal: true

require 'spec_helper'

describe Base64Validator do

  context 'has a valid value' do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :code, :name
        validates :code, base64: true
      end
    end

    subject { klass.new }

    it { should allow_value('YW55IGNhcm5hbCBwbGVhcw==').for(:code) }
    it { should allow_value('YW55IGNhcm5hbCBwbGVhc3U=').for(:code) }
    it { should allow_value('YW55IGNhcm5hbCBwbGVhc3Vy').for(:code) }
    it { should allow_value('YW55IGNhcm5hbCBwbGVhc3VyZQ==').for(:code) }
    it { should allow_value('YW55IGNhcm5hbCBwbGVhc3VyZS4=').for(:code) }

    it { should_not allow_value('').for(:code) }
    it { should_not allow_value(' ').for(:code) }
    it { should_not allow_value(nil).for(:code) }
    it { should_not allow_value('1a.b2').for(:code) }
    it { should_not allow_value('1a b2').for(:code) }
    it { should_not allow_value('1a.b2==').for(:code) }

    it { should ensure_valid_base64_format_of(:code) }
    it { should_not ensure_valid_base64_format_of(:name) }
  end

end
