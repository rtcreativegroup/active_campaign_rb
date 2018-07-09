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
  let(:adapter) { v2_adapter }
  let(:v2_adapter) { ActiveCampaign::V2::Adapter }
  let(:v3_adapter) { ActiveCampaign::V3::Adapter }

  describe '#initialize' do
    shared_examples 'takes a base_url and an optional adapter' do
      it 'calls adapter with the base_url' do
        expect(adapter).to receive(:call).with(base_url)
        subject
      end
    end

    context 'nil adapter' do
      let(:adapter) { nil }

      it 'calls the default adapter with the base_url' do
        expect(ActiveCampaign::V2::Adapter).to receive(:call).with(base_url)
        subject
      end
    end

    context 'v2 api adapter' do
      let(:adapter) { v2_adapter }

      it_behaves_like 'takes a base_url and an optional adapter'
    end

    context 'v3 api adapter' do
      let(:adapter) { v3_adapter }

      it_behaves_like 'takes a base_url and an optional adapter'
    end

    it 'takes a key and sets it to attr' do
      expect(connection.key).to eq('abc123')
    end

    context 'defaults from environment variables' do
      ENV['ACTIVE_CAMPAIGN_URL'] = 'http://environmental.com'
      ENV['ACTIVE_CAMPAIGN_KEY'] = 'my-environmental-key'
      subject(:connection) { described_class.new }

      it "calls the adapter with ENV['ACTIVE_CAMPAIGN_URL']" do
        expect(ActiveCampaign::V2::Adapter).to receive(:call).with('http://environmental.com')
        subject
      end

      it "defaults key to ENV['ACTIVE_CAMPAIGN_KEY']" do
        expect(connection.key).to eq('my-environmental-key')
      end
    end
  end

  context 'HTTP verbs' do
    before(:each) do
      allow(ActiveCampaign::V2::Adapter).to receive(:call).with(base_url).and_return(base_url)
    end

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
