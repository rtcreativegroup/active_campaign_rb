RSpec.describe ActiveCampaign::V2::Clients::Tracking do
  subject(:client) { ActiveCampaign::V2::Client.new(base_url: 'https://example.api-us1.com', timeout: 5) }

  describe '#track_event_add' do
    it 'posts to the trackcmp.net event endpoint' do
      stub_request(:post, /trackcmp\.net/)
        .to_return(body: '{"success":1}', headers: { 'Content-Type' => 'application/json' })

      client.track_event_add(event: 'signup', eventdata: 'data', email: 'a@example.com')

      expect(a_request(:post, 'https://trackcmp.net/event').with(query: hash_including({}))).to have_been_made
    end
  end
end
