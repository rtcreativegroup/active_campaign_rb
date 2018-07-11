require 'spec_helper'

RSpec.describe ActiveCampaign::V2::Adapters::EventAddingAdapter do
  subject(:adapter) do
    described_class.new(
      base_url: base_url,
      key: key,
      tracking_account_id: tracking_account_id,
      event_key: event_key,
    )
  end
  let(:base_url) { 'http://www.example.com' }
  let(:key) { 'Test-Key' }
  let(:tracking_account_id) { '12345' }
  let(:event_key) { 'My-Event-Key' }

  describe '.base_url' do
    it 'returns the endpoint, which is used for v2 event adding api' do
      expect(adapter.endpoint).to eq('https://trackcmp.net/event')
    end
  end

  describe '.default_params' do
    it 'returns the default params, which are used for v2 event adding api' do
      expect(adapter.default_params).to eq({
                                            api_key: 'Test-Key',
                                            actid: '12345',
                                            key: 'My-Event-Key',
                                          })
    end
  end
end
