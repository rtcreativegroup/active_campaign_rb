# frozen_string_literal: true

RSpec.describe ActiveCampaign::V3::Entities::DeepDataIntegrations::EComOrder do
  let(:attributes) do
    {
      externalid: 42,
      email: 'buyer@example.com',
      orderProducts: [{ name: 'Clip', price: '999', quantity: '2', externalid: 7 }],
      totalPrice: 1998,
      currency: 'USD',
      connectionid: 3,
      customerid: 5,
      orderDate: Time.utc(2026, 11, 9, 12).to_s,
    }
  end

  it "raises an ArgumentError naming 'customerid' when the customer is unknown" do
    expect { described_class.new(attributes.merge(customerid: nil)) }
      .to raise_error(ArgumentError, a_string_including("The property 'customerid' is required"))
  end

  it 'does not require externalid, connectionid or customerid when id is present' do
    update = attributes.except(:externalid, :connectionid, :customerid).merge(id: 9)

    expect { described_class.new(update) }.not_to raise_error
  end

  describe 'serialized' do
    subject(:json) { JSON.parse(described_class.new(attributes).to_json) }

    it 'sends totalPrice as a string' do
      expect(json['totalPrice']).to eq('1998')
    end

    it 'sends externalid as a string' do
      expect(json['externalid']).to eq('42')
    end

    it 'sends product price and quantity as integers' do
      expect(json['orderProducts']).to contain_exactly(a_hash_including('price' => 999, 'quantity' => 2))
    end

    it 'sends orderDate as ISO 8601' do
      expect(json['orderDate']).to eq('2026-11-09T12:00:00+00:00')
    end
  end
end
