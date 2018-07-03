require 'spec_helper'

RSpec.describe ActiveCampaign::V2::Adapter do
  describe '.call' do
    subject(:adapter) { described_class.('http://www.example.com') }

    it 'returns the base_url, which is used for v2 api' do
      expect(subject).to eq('http://www.example.com')
    end
  end
end
