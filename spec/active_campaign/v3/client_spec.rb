# frozen_string_literal: true

RSpec.describe ActiveCampaign::V3::Client do
  subject(:client) { described_class.new(base_url: 'https://example.api-us1.com', key: 'key', timeout: 5) }

  let(:api_url) { 'https://example.api-us1.com/api/3' }

  def json_body(request)
    JSON.parse(request.body.to_s)
  rescue JSON::ParserError
    nil
  end

  describe '#get' do
    it 'fills path params without mutating a frozen path' do
      stub_request(:get, 'https://example.api-us1.com/api/3/contacts/1')

      expect { client.get('/contacts/:id'.freeze, { id: 1 }, { path: :id }) }.not_to raise_error
    end
  end

  describe 'responses' do
    {
      401 => ActiveCampaign::UnauthorizedError,
      403 => ActiveCampaign::ForbiddenError,
      404 => ActiveCampaign::NotFoundError,
      422 => ActiveCampaign::UnprocessableEntityError,
      500 => ActiveCampaign::InternalServerError,
      503 => ActiveCampaign::ServiceUnavailableError,
    }.each do |status, error_class|
      context "when the status is #{status}" do
        it "raises #{error_class}" do
          stub_request(:get, "#{api_url}/contacts").to_return(status: status)

          expect { client.get('/contacts') }.to raise_error(error_class)
        end
      end
    end

    context 'when a 200 JSON body has an errors key' do
      it 'raises ActiveCampaign::Error' do
        stub_request(:get, "#{api_url}/contacts").to_return(
          status: 200,
          body: '{"errors":[{"title":"Email is invalid"}]}',
          headers: { 'Content-Type' => 'application/json' }
        )

        expect { client.get('/contacts') }.to raise_error(ActiveCampaign::Error)
      end
    end

    context 'when a 200 body is not JSON' do
      it 'returns the body string' do
        stub_request(:get, "#{api_url}/contacts").to_return(
          status: 200,
          body: 'OK',
          headers: { 'Content-Type' => 'text/plain' }
        )

        expect(client.get('/contacts')).to eq('OK')
      end
    end
  end

  describe 'requests' do
    before { stub_request(:any, %r{\Ahttps://example\.api-us1\.com/}) }

    it 'sends the constructor key as the Api-Token header under the /api/3 prefix' do
      client.get('/contacts')

      expect(a_request(:get, "#{api_url}/contacts").with(headers: { 'Api-Token' => 'key' })).to have_been_made
    end

    %i[get post put delete].each do |verb|
      it "sends ##{verb} as an HTTP #{verb.upcase}" do
        client.public_send(verb, '/contacts')

        expect(a_request(verb, "#{api_url}/contacts")).to have_been_made
      end
    end

    it 'routes params by param_types, drops the rest and wraps the JSON body in object_name' do
      client.put(
        '/contacts/:id',
        { id: 7, search: 'ann', email: 'ann@example.com', unlisted: 'dropped' },
        { path: :id, query: [:search], body: [:email] },
        :contact
      )

      expect(
        a_request(:put, "#{api_url}/contacts/7")
          .with(query: { 'search' => 'ann' }) { |req| json_body(req) == { 'contact' => { 'email' => 'ann@example.com' } } }
      ).to have_been_made
    end
  end
end
