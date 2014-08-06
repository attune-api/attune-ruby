require 'spec_helper'

describe Attune::Client do
  let(:client){ described_class.new(options) }
  subject { client }

  context "with defaults" do
    let(:options){ {} }
    specify { expect(subject.endpoint).to eq(Attune::Default::ENDPOINT) }
  end
  context "with custom endpoint" do
    let(:endpoint){ 'http://example.com/' }
    let(:options){ {endpoint: endpoint} }
    specify { expect(subject.endpoint).to eq(endpoint) }
  end

  let(:options){ {endpoint: 'http://example.com:8080/', middleware: middleware} }
  let(:stubs) { Faraday::Adapter::Test::Stubs.new }
  let(:middleware) do
    Faraday::Builder.new do |builder|
      builder.use Attune::ParamFlattener
      builder.adapter :test, stubs
    end
  end

  describe "API errors" do
    it "will raise timeout" do
      stubs.post("anonymous", nil){ raise Faraday::Error::TimeoutError.new("test") }
      expect {
        client.anonymous.create
      }.to raise_exception(Faraday::Error::TimeoutError)
      stubs.verify_stubbed_calls
    end
    it "will raise ConnectionFailed" do
      stubs.post("anonymous", nil){ raise Faraday::Error::ConnectionFailed.new("test") }
      expect {
        client.anonymous.create
      }.to raise_exception(Faraday::Error::ConnectionFailed)
      stubs.verify_stubbed_calls
    end
    it "will raise ConnectionFailed on Errno::ENOENT" do
      stubs.post("anonymous", nil){ raise Errno::ENOENT.new("test") }
      expect {
        client.anonymous.create
      }.to raise_exception(Faraday::Error::ConnectionFailed)
    end
    it "will raise AuthenticationException" do
      stubs.post("oauth/token",
        {:client_id=>"id", :client_secret=>"secret", grant_type: :client_credentials}
      ){ [200, {}, %[{"error":"invalid_client","error_description":"Bad client credentials"}]] }
      expect {
        client.get_auth_token("id", "secret")
      }.to raise_exception(Attune::AuthenticationException)
      stubs.verify_stubbed_calls
    end
  end

  describe "disabled" do
    context "with raise" do
      let(:options){ {disabled: true, exception_handler: :raise} }
      it "will raise DisalbedException" do
        expect {
          client.anonymous.create
        }.to raise_exception(Attune::DisabledException)
      end
    end
    context "with mock" do
      let(:options){ {disabled: true, exception_handler: :mock} }

      it "mocks get_auth_token" do
        result = client.get_auth_token("id", "secret")
        expect(result).to match(/^[a-z0-9\-]+$/)
      end

      it "mocks create_anonymous with no id" do
        result = client.anonymous.create
        expect(result.id).to match(/^[a-z0-9\-]+$/)
      end
      describe "mocks get_rankings" do
        let(:entities) { %w[1001 1002 1003 1004] }
        let(:expected) { entities.map { |e| e.to_s } }

        before(:each) do
          params = Attune::Model::RankingParams.new(
            anonymous: 'abcd123',
            view: 'b/mens-pants',
            entity_type: 'products',
            ids: entities
          )
          @result = client.entities.get_rankings(params)
        end

        context "with entities sent as strings" do
          it "returns entities in order sent" do
            expect(@result.ranking).to eq expected
          end
        end

        context "with entities sent as integers" do
          let(:entities) { [1001, 1002, 1003, 1004] }

          it "returns entities in order sent as strings" do
            expect(@result.ranking).to eq expected
          end
        end
      end
      describe "mocks multi_get_rankings" do
        let(:entities) { %w[1001 1002 1003 1004] }
        let(:expected) { [entities.map { |e| e.to_s }] }

        before(:each) do
          params = Attune::Model::RankingParams.new(
            anonymous: 'abcd123',
            view: 'b/mens-pants',
            entity_type: 'products',
            ids: entities
          )
          batch_request = Attune::Model::BatchRankingRequest.new
          batch_request.requests = [params]
          @result = client.entities.batch_get_rankings(batch_request)
        end

        context "with entities sent as strings" do
          it "returns entities in order sent" do
            rankings = @result.results.map(&:ranking)
            expect(rankings).to eq expected
          end
        end

        context "with entities sent as integers" do
          let(:entities) { [1001, 1002, 1003, 1004] }

          it "returns entities in order sent as strings" do
            rankings = @result.results.map(&:ranking)
            expect(rankings).to eq expected
          end
        end
      end
    end
  end

  it "can get_auth_token requesting a token" do
    stubs.post("oauth/token",
      {:client_id=>"id", :client_secret=>"secret", grant_type: :client_credentials}
    ){ [200, {}, %[{"access_token":"secret-token","token_type":"bearer"}]] }
    token = client.get_auth_token('id', 'secret')

    expect(token).to eq('secret-token')
  end

  it "can create_anonymous generating an id" do
    stubs.post("anonymous", nil){ [200, {location: 'urn:id:abcd123'}, %[{"id": "abcd123"}]] }
    result = client.anonymous.create
    stubs.verify_stubbed_calls

    expect(result.id).to eq('abcd123')
  end

  it "can bind" do
    stubs.put("anonymous/abcd123", %[{"customer":"foobar"}]){ [200, {}, nil] }
    client.anonymous.update('abcd123', Attune::Model::Customer.new(customer:'foobar'))
    stubs.verify_stubbed_calls
  end

  it "get anonymous using existing id" do
    stubs.get("anonymous/abcd123"){ [200, {}, %[{"customer":"foobar"}]] }
    response = client.anonymous.get('abcd123')
    stubs.verify_stubbed_calls

    expect(response.customer).to eq('foobar')
  end

  describe "get_rankings" do
    before(:each) do
      ranking_request = {
        anonymous: 'abcd123',
        view: 'b/mens-pants',
        entity_type: 'products',
        ids: %w[1001, 1002, 1003, 1004]
      }
      stubs.post("entities/ranking", ranking_request.to_json){ [200, nil, %[{"ranking":["1004","1003","1002","1001"]}]] }
      @rankings = client.entities.get_rankings(ranking_request)
      stubs.verify_stubbed_calls
    end

    it "can get ranked entities" do
      expect(@rankings.ranking).to eq(%W[1004 1003 1002 1001])
    end
  end

  describe "multi_get_rankings" do
    before(:each) do
      batch_request = {requests: [
        {
          anonymous: '0cddbc0-6114-11e3-949a-0800200c9a66',
          view: 'b/mens-pants',
          entity_type: 'products',
          ids: %w[1001, 1002, 1003, 1004]
        },
        {
          anonymous: '0cddbc0-6114-11e3-949a-0800200c9a66',
          view: 'b/mens-pants',
          entity_type: 'products',
          ids: %w[2001, 2002, 2003, 2004]
        }
      ]}
      stubs.post("entities/ranking/many", batch_request.to_json) do
        [200, nil, <<-JSON]
  {
      "results": [
          {
              "ranking": [
                  "1004",
                  "1003",
                  "1002",
                  "1001"
              ]
          },
          {
              "ranking": [
                  "2004",
                  "2003",
                  "2002",
                  "2001"
              ]
          }
      ]
  }
        JSON
      end
      @results = client.entities.batch_get_rankings(batch_request)
      stubs.verify_stubbed_calls
    end

    it "can get ranked entities" do
      rankings = @results.results.map {|r| r.ranking }
      expect(rankings).to eq [
        %W[1004 1003 1002 1001],
        %W[2004 2003 2002 2001]
      ]
    end
  end
end

