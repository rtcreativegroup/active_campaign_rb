require 'spec_helper'

RSpec.describe ActiveCampaign::V3::Adapter do
  describe '.call' do
    subject(:adapter) { described_class.('http://www.example.com') }

    it 'returns the base_url, appended with v3 api path' do
      expect(subject).to eq('http://www.example.com/api/3')
    end
  end
end
