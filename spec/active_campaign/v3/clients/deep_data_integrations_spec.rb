# frozen_string_literal: true

RSpec.describe ActiveCampaign::V3::Clients::DeepDataIntegrations do
  subject(:client) { ActiveCampaign::V3::Client.new(base_url: 'https://example.api-us1.com', key: 'key', timeout: 5) }

  let(:api) { 'https://example.api-us1.com/api/3' }

  before { stub_request(:any, /example\.api-us1\.com/) }

  def json_body(expected)
    ->(request) { JSON.parse(request.body) == expected }
  end

  [
    [
      :e_commerce_customer_create,
      { connectionid: 3, externalid: 7, email: 'buyer@example.com' },
      :post, '/ecomCustomers',
      { 'ecomCustomer' => { 'connectionid' => 3, 'externalid' => 7, 'email' => 'buyer@example.com' } },
    ],
    [
      :e_commerce_customer_update,
      { id: 5, email: 'buyer@example.com' },
      :put, '/ecomCustomers/5',
      { 'ecomCustomer' => { 'email' => 'buyer@example.com' } },
    ],
  ].each do |method, args, verb, path, body|
    describe "##{method}" do
      it "sends #{verb.upcase} #{path} with the #{body.keys.first} body" do
        client.public_send(method, **args)

        expect(a_request(verb, "#{api}#{path}").with(&json_body(body))).to have_been_made
      end
    end
  end

  [
    [:e_commerce_customer_list, '/ecomCustomers'],
    [:e_commerce_order_list, '/ecomOrders'],
  ].each do |method, path|
    describe "##{method}" do
      it "sends GET #{path} with the filters as query params" do
        client.public_send(method, 'filters[externalid]': 7, 'filters[email]': 'buyer@example.com')

        expect(
          a_request(:get, "#{api}#{path}")
            .with(query: { 'filters[externalid]' => '7', 'filters[email]' => 'buyer@example.com' })
        ).to have_been_made
      end
    end
  end

  describe '#e_commerce_order_delete' do
    it 'sends DELETE /ecomOrders/:id' do
      client.e_commerce_order_delete(id: 9)

      expect(a_request(:delete, "#{api}/ecomOrders/9")).to have_been_made
    end
  end

  describe '#e_commerce_order_create' do
    it 'sends POST /ecomOrders with the coerced order wrapped in ecomOrder' do
      client.e_commerce_order_create(
        externalid: 42,
        source: 1,
        email: 'buyer@example.com',
        orderProducts: [{ name: 'Clip', price: 999, quantity: 2, externalid: 7, category: 'Video > Stock' }],
        totalPrice: 1998,
        currency: 'USD',
        connectionid: 3,
        customerid: 5,
        orderNumber: nil,
        orderUrl: nil,
        orderDate: Time.utc(2026, 11, 9, 12).to_s,
        shippingMethod: 'Download',
      )

      expected = {
        'ecomOrder' => {
          'externalid' => '42',
          'source' => 1,
          'email' => 'buyer@example.com',
          'orderProducts' => [
            { 'name' => 'Clip', 'price' => 999, 'quantity' => 2, 'externalid' => '7', 'category' => 'Video > Stock' },
          ],
          'totalPrice' => '1998',
          'currency' => 'USD',
          'connectionid' => 3,
          'customerid' => 5,
          'orderDate' => '2026-11-09T12:00:00+00:00',
          'shippingMethod' => 'Download',
        },
      }
      expect(a_request(:post, "#{api}/ecomOrders").with(&json_body(expected))).to have_been_made
    end
  end
end
