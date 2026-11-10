# frozen_string_literal: true

RSpec.describe ActiveCampaign::V2::Client do
  subject(:client) { described_class.new(base_url: base_url) }

  let(:base_url) { 'https://example.api-us1.com' }
  let(:api_key) { 'test-key' }

  around do |example|
    config = ActiveCampaign::Settings.config
    previous = { api_key: config.api_key, base_url: config.base_url }
    config.api_key = api_key
    config.base_url = base_url
    example.run
  ensure
    config.api_key = previous[:api_key]
    config.base_url = previous[:base_url]
  end

  describe 'responses' do
    it 'returns the body String when the response is not JSON' do
      stub_request(:get, "#{base_url}/admin/api.php")
        .with(query: hash_including({}))
        .to_return(body: 'OK', headers: { 'Content-Type' => 'text/html' })

      expect(client.get('/admin/api.php')).to eq('OK')
    end
  end

  describe 'requests' do
    before do
      stub_request(:any, /example\.api-us1\.com/).to_return(body: '')
    end

    it 'sends api_key and api_output=json to /admin/api.php' do
      client.get('/admin/api.php', query: { api_action: 'list_list' })

      expect(
        a_request(:get, "#{base_url}/admin/api.php")
          .with(query: { 'api_action' => 'list_list', 'api_key' => api_key, 'api_output' => 'json' })
      ).to have_been_made
    end

    it 'sends only api_key to other paths' do
      client.get('/other/path')

      expect(a_request(:get, "#{base_url}/other/path").with(query: { 'api_key' => api_key })).to have_been_made
    end

    it 'sends a POST body form-encoded with a form Content-Type' do
      client.post('/admin/api.php', body: { email: 'ann@example.com', first_name: 'Ann' })

      expect(
        a_request(:post, "#{base_url}/admin/api.php")
          .with(
            query: hash_including({}),
            body: { 'email' => 'ann@example.com', 'first_name' => 'Ann' },
            headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }
          )
      ).to have_been_made
    end

    it 'keeps caller-supplied headers on a POST' do
      client.post('/admin/api.php', headers: { 'X-Request-Id' => 'abc123' })

      expect(
        a_request(:post, "#{base_url}/admin/api.php")
          .with(query: hash_including({}), headers: { 'X-Request-Id' => 'abc123' })
      ).to have_been_made
    end
  end
end
