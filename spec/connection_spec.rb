require 'spec_helper'

RSpec.describe ActiveCampaign::Connection do
  subject(:connection) do
    described_class.new(
      base_url: base_url,
      key: 'abc123',
      adapter: adapter
    )
  end
  let(:base_url) { 'http://www.example.com' }
  let(:adapter) { nil }
  let(:versioned_base_url) { 'http://www.example.com' }

  describe '#initialize' do
    shared_examples 'takes a base_url and an optional adapter' do
      it 'calls adapter with base_url and sets return value to attr' do
        expect(connection.base_url.to_s).to eq(versioned_base_url)
      end
    end

    context 'default adapter' do
      it_behaves_like 'takes a base_url and an optional adapter'
    end

    context 'v2 api adapter' do
      let(:adapter) { ActiveCampaign::V2::Adapter }
      let(:versioned_base_url) { 'http://www.example.com' }

      it_behaves_like 'takes a base_url and an optional adapter'
    end

    context 'v3 api adapter' do
      let(:adapter) { ActiveCampaign::V3::Adapter }
      let(:versioned_base_url) { 'http://www.example.com/api/3' }

      it_behaves_like 'takes a base_url and an optional adapter'
    end

    it 'takes a key and sets it to attr' do
      expect(connection.key).to eq('abc123')
    end

    context 'defaults from environment variables' do
      ENV['ACTIVE_CAMPAIGN_URL'] = 'http://environmental.com'
      ENV['ACTIVE_CAMPAIGN_KEY'] = 'my-environmental-key'
      subject(:connection) { described_class.new }

      it "defaults base_url to ENV['ACTIVE_CAMPAIGN_URL']" do
        expect(connection.base_url).to eq('http://environmental.com')
      end

      it "defaults key to ENV['ACTIVE_CAMPAIGN_KEY']" do
        expect(connection.key).to eq('my-environmental-key')
      end
    end
  end

  context 'HTTP verbs' do
    shared_examples_for 'request method' do |method|
      it "calls #{method.to_s.upcase} on the supplied uri appended to the base_uri" do
        shared_stub_request(
          method: method,
          request: {
            query: {
              api_key: 'abc123',
              api_output: 'json',
              test_key: 'test_value',
            }
          },
          response: {
            body: {
              response: 'test_response'
            }.to_json,
            status: 200
          }
        )

        expect(connection.public_send(method, '/test', params: { test_key: 'test_value' }))
          .to eq('response' => 'test_response')
      end

      context 'with header args' do
        it 'sets the header args' do
          shared_stub_request(
            method: method,
            request: {
              query: {
                api_key: 'abc123',
                api_output: 'json',
              },
              headers: {
                'Content-Type': 'application/json'
              },
            }
          )

          connection.public_send(method, '/test', headers: { 'Content-Type': 'application/json' })
        end
      end

      context 'with form args' do
        it 'sets the Content-Type to application/x-www-form-urlencoded' do
          shared_stub_request(
            method: method,
            request: {
              headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
              },
              query: {
                api_key: 'abc123',
                api_output: 'json',
              },
            }
          )

          connection.public_send(method, '/test', form: { test_key: 'test_value' })
        end
      end

      context 'error cases' do
        [400, 403, 404, 500].each do |code|
          it "returns the parsed error for status code #{code}" do
            shared_stub_request(
              method: method,
              request: {
                query: {
                  api_key: 'abc123',
                  api_output: 'json',
                },
              },
              response: {
                status: code,
                body: {
                  status: 'error',
                  error: 'message'
                }.to_json
              }
            )

            expect(connection.public_send(method, '/test')).to(
              eq('status' => 'error', 'error' => 'message'),
              "status code #{code} did not return proper value"
            )
          end
        end
      end

      def shared_stub_request(
        method:,
        path: '/test',
        request: { body: '' },
        response: { body: {}.to_json }
      )
        stub_request(method, base_url + path)
          .with(request)
          .to_return(response)
      end
    end

    describe '#get' do
      it_behaves_like 'request method', :get
    end

    describe '#post' do
      it_behaves_like 'request method', :post
    end

    describe '#put' do
      it_behaves_like 'request method', :put
    end

    describe '#delete' do
      it_behaves_like 'request method', :delete
    end
  end
end