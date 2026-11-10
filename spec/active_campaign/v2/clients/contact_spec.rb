# frozen_string_literal: true

RSpec.describe ActiveCampaign::V2::Clients::Contact do
  subject(:client) { ActiveCampaign::V2::Client.new(base_url: base_url) }

  let(:base_url) { 'https://example.api-us1.com' }
  let(:api_url) { "#{base_url}/admin/api.php" }

  before do
    stub_request(:any, /example\.api-us1\.com/).to_return(body: '')
  end

  def form_pairs(encoded)
    URI.decode_www_form(encoded.to_s).sort
  end

  {
    contact_sync: {
      args: { email: 'ann@example.com', first_name: 'Ann' },
      body: [%w[email ann@example.com], %w[first_name Ann]],
    },
    contact_edit: {
      args: { id: 7, email: 'ann@example.com', p: 3, first_name: 'Ann', api_output: :json },
      body: [%w[id 7], %w[email ann@example.com], %w[p[3] 3], %w[first_name Ann], %w[api_output json]],
    },
    contact_tag_add: {
      args: { email: 'ann@example.com', tags: %w[vip newsletter] },
      body: [%w[email ann@example.com], %w[tags[] vip], %w[tags[] newsletter]],
    },
    contact_tag_remove: {
      args: { email: 'ann@example.com', tags: %w[vip newsletter] },
      body: [%w[email ann@example.com], %w[tags[] vip], %w[tags[] newsletter]],
    },
  }.each do |method, shape|
    describe "##{method}" do
      it "posts api_action=#{method} with a form body" do
        client.public_send(method, **shape[:args])

        expect(
          a_request(:post, api_url).with(query: hash_including('api_action' => method.to_s)) do |req|
            form_pairs(req.body) == shape[:body].sort
          end
        ).to have_been_made
      end
    end
  end

  describe '#custom_field_search' do
    it 'gets contact_list filtered by the upcased custom field' do
      client.custom_field_search(field: :customer_id, value: 'abc 123')

      expect(
        a_request(:get, api_url).with(query: hash_including('api_action' => 'contact_list')) do |req|
          form_pairs(req.uri.query).include?(['filters[fields][%CUSTOMER_ID%]', 'abc 123'])
        end
      ).to have_been_made
    end
  end
end
