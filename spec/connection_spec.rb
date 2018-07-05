require 'spec_helper'

RSpec.describe ActiveCampaign::Connection do
  describe '#initialize' do
    subject(:connection) do
      described_class.new(
        base_url: base_url,
        key: 'abc123',
        adapter: adapter
      )
    end
    let(:base_url) { 'http://www.example.com' }
    let(:adapter) { v2_adapter }
    let(:v2_adapter) { ActiveCampaign::V2::Adapter }
    let(:v3_adapter) { ActiveCampaign::V3::Adapter }

    shared_examples 'takes a base_url and an optional adapter' do
      it 'calls adapter with the base_url' do
        expect(adapter).to receive(:call).with(base_url)
        subject
      end
    end

    context 'nil adapter' do
      let(:adapter) { nil }

      it 'calls the default adapter with the base_url' do
        expect(ActiveCampaign::V2::Adapter).to receive(:call).with(base_url)
        subject
      end
    end

    context 'v2 api adapter' do
      let(:adapter) { v2_adapter }

      it_behaves_like 'takes a base_url and an optional adapter'
    end

    context 'v3 api adapter' do
      let(:adapter) { v3_adapter }

      it_behaves_like 'takes a base_url and an optional adapter'
    end

    it 'takes a key and sets it to attr' do
      expect(connection.key).to eq('abc123')
    end

    context 'defaults from environment variables' do
      ENV['ACTIVE_CAMPAIGN_URL'] = 'http://environmental.com'
      ENV['ACTIVE_CAMPAIGN_KEY'] = 'my-environmental-key'
      subject(:connection) { described_class.new }

      it "calls the adapter with ENV['ACTIVE_CAMPAIGN_URL']" do
        expect(ActiveCampaign::V2::Adapter).to receive(:call).with('http://environmental.com')
        subject
      end

      it "defaults key to ENV['ACTIVE_CAMPAIGN_KEY']" do
        expect(connection.key).to eq('my-environmental-key')
      end
    end
  end
end
