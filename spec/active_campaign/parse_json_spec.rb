# frozen_string_literal: true

RSpec.describe ActiveCampaign::ParseJson do
  let(:base_url) { 'https://example.api-us1.com' }
  let(:json_headers) { { 'Content-Type' => 'application/json; charset=utf-8' } }
  let(:html_body) { '<html><body>Service Unavailable</body></html>' }

  before do
    ActiveCampaign::Settings.config.base_url = base_url
    ActiveCampaign::Settings.config.api_key = 'test'
  end

  describe 'through ActiveCampaign::V2::Client' do
    subject(:request) { ActiveCampaign::V2::Client.new.post('/admin/api.php', query: { api_action: 'contact_edit' }) }

    def stub_v2(body)
      stub_request(:post, "#{base_url}/admin/api.php")
        .with(query: hash_including('api_action' => 'contact_edit'))
        .to_return(status: 200, body: body.dup, headers: json_headers)
    end

    it 'raises with the status and body excerpt when the body is HTML' do
      stub_v2(html_body)

      expect { request }.to raise_error(
        ActiveCampaign::Error,
        "ActiveCampaign returned invalid JSON (HTTP 200): #{html_body}"
      )
    end

    it 'raises with an empty-body marker when the body is empty' do
      stub_v2('')

      expect { request }.to raise_error(
        ActiveCampaign::Error,
        'ActiveCampaign returned invalid JSON (HTTP 200): (empty body)'
      )
    end

    it 'collapses whitespace and truncates the excerpt to 120 characters' do
      stub_v2("<html>\n  #{'x' * 200}</html>")

      expect { request }.to raise_error(
        ActiveCampaign::Error,
        "ActiveCampaign returned invalid JSON (HTTP 200): <html> #{'x' * 110}..."
      )
    end

    it 'returns the parsed body with string keys for valid JSON' do
      stub_v2('{"result_code":1,"subscriber_id":42}')

      expect(request).to eq('result_code' => 1, 'subscriber_id' => 42)
    end

    it 'raises the AC result message when result_code is 0' do
      stub_v2('{"result_code":0,"result_message":"Contact not found"}')

      expect { request }.to raise_error(ActiveCampaign::Error, 'Contact not found')
    end
  end

  describe 'through ActiveCampaign::V3::Client' do
    subject(:request) { ActiveCampaign::V3::Client.new.post('/contactAutomations') }

    def stub_v3(body)
      stub_request(:post, "#{base_url}/api/3/contactAutomations")
        .to_return(status: 200, body: body.dup, headers: json_headers)
    end

    it 'raises with the status and body excerpt when the body is HTML' do
      stub_v3(html_body)

      expect { request }.to raise_error(
        ActiveCampaign::Error,
        "ActiveCampaign returned invalid JSON (HTTP 200): #{html_body}"
      )
    end

    it 'returns the parsed body with string keys for valid JSON' do
      stub_v3('{"contactAutomation":{"id":"7"}}')

      expect(request).to eq('contactAutomation' => { 'id' => '7' })
    end
  end
end
