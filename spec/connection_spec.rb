require 'spec_helper'

RSpec.describe ActiveCampaign::Connection do
  describe '#initialize' do
    subject(:connection) do
      described_class.new(
        base_url: 'http://www.example.com',
        key: 'abc123',
        adapter: adapter
      )
    end
    let(:adapter) { nil }
    let(:versioned_base_url) { 'http://www.example.com' }

    shared_examples 'takes a base_url and an optional adapter' do
      it 'calls adapter with base_url and sets return value to attr' do
        expect(connection.base_url.to_s).to eq(versioned_base_url)
      end
    end

    context 'default adapter' do
      it_behaves_like 'takes a base_url and an optional adapter'
    end

    context 'v2 api adapter' do
      let(:adapter) { ActiveCampaign::V2::Adapter }
      let(:versioned_base_url) { 'http://www.example.com' }

      it_behaves_like 'takes a base_url and an optional adapter'
    end

    context 'v3 api adapter' do
      let(:adapter) { ActiveCampaign::V3::Adapter }
      let(:versioned_base_url) { 'http://www.example.com/api/3' }

      it_behaves_like 'takes a base_url and an optional adapter'
    end

    it 'takes a key and sets it to attr' do
      expect(connection.key).to eq('abc123')
    end

    context 'defaults from environment variables' do
      ENV['ACTIVE_CAMPAIGN_URL'] = 'http://environmental.com'
      ENV['ACTIVE_CAMPAIGN_KEY'] = 'my-environmental-key'
      subject(:connection) { described_class.new }

      it "defaults base_url to ENV['ACTIVE_CAMPAIGN_URL']" do
        expect(connection.base_url).to eq('http://environmental.com')
      end

      it "defaults key to ENV['ACTIVE_CAMPAIGN_KEY']" do
        expect(connection.key).to eq('my-environmental-key')
      end
    end
  end
end
