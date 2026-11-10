# frozen_string_literal: true

RSpec.describe ActiveCampaign::V3::Client do
  subject(:client) { described_class.new(base_url: 'https://example.api-us1.com', key: 'key', timeout: 5) }

  let(:api_url) { 'https://example.api-us1.com/api/3' }

  before { stub_request(:any, %r{\Ahttps://example\.api-us1\.com/}) }

  def json_body(request)
    JSON.parse(request.body.to_s)
  rescue JSON::ParserError
    nil
  end

  describe '#contact_sync' do
    it 'posts the contact fields to /contact/sync' do
      client.contact_sync(email: 'ann@example.com', firstName: 'Ann')

      expect(
        a_request(:post, "#{api_url}/contact/sync").with do |req|
          json_body(req) == { 'contact' => { 'email' => 'ann@example.com', 'firstName' => 'Ann' } }
        end
      ).to have_been_made
    end
  end

  describe '#contact_automation_create' do
    it 'posts the contact and automation ids to /contactAutomations' do
      client.contact_automation_create(contact_id: 42, automation_id: 7)

      expect(
        a_request(:post, "#{api_url}/contactAutomations").with do |req|
          json_body(req) == { 'contactAutomation' => { 'contact' => 42, 'automation' => 7 } }
        end
      ).to have_been_made
    end
  end
end
