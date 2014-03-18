require 'spec_helper'

describe Attune::Client do
  let(:client){ described_class.new(options) }
  subject { client }

  context "with defaults" do
    let(:options){ {} }
    specify { expect(subject.endpoint).to eq(Attune::Default::ENDPOINT) }
    specify { expect(subject.middleware).to eq(Attune::Default::MIDDLEWARE) }
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
      stubs.post("anonymous", %[{"user_agent":"Mozilla/5.0"}]){ raise Faraday::Error::TimeoutError.new("test") }
      expect {
        client.create_anonymous(user_agent: 'Mozilla/5.0')
      }.to raise_exception(Faraday::Error::TimeoutError)
      stubs.verify_stubbed_calls
    end
    it "will raise ConnectionFailed" do
      stubs.post("anonymous", %[{"user_agent":"Mozilla/5.0"}]){ raise Faraday::Error::ConnectionFailed.new("test") }
      expect {
        client.create_anonymous(user_agent: 'Mozilla/5.0')
      }.to raise_exception(Faraday::Error::ConnectionFailed)
      stubs.verify_stubbed_calls
    end
  end

  describe "disabled" do
    context "with raise" do
      let(:options){ {disabled: true, exception_handler: :raise} }
      it "will raise DisalbedException" do
        expect {
          client.create_anonymous(user_agent: 'Mozilla/5.0')
        }.to raise_exception(Attune::DisabledException)
      end
    end
    context "with mock" do
      let(:options){ {disabled: true, exception_handler: :mock} }
      it "mocks create_anonymous with an id" do
        result = client.create_anonymous(id: '12345', user_agent: 'Mozilla/5.0')
        expect(result).to eq('12345')
      end
      it "mocks create_anonymous with no id" do
        result = client.create_anonymous(user_agent: 'Mozilla/5.0')
        expect(result).to match(/^[a-z0-9\-]+$/)
      end
      it "mocks get_rankings" do
        result = client.get_rankings(
          id: 'abcd123',
          view: 'b/mens-pants',
          collection: 'products',
          entities: %w[1001, 1002, 1003, 1004]
        )
        expect(result).to eq %w[1001, 1002, 1003, 1004]
      end
      it "mocks multi_get_rankings" do
        result = client.multi_get_rankings([
          id: 'abcd123',
          view: 'b/mens-pants',
          collection: 'products',
          entities: %w[1001, 1002, 1003, 1004]
        ])
        expect(result).to eq [%w[1001, 1002, 1003, 1004]]
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
    stubs.post("anonymous", %[{"user_agent":"Mozilla/5.0"}]){ [200, {location: 'urn:id:abcd123'}, nil] }
    id = client.create_anonymous(user_agent: 'Mozilla/5.0')
    stubs.verify_stubbed_calls

    expect(id).to eq('abcd123')
  end

  it "can bind" do
    stubs.put("bindings/anonymous=abcd123&customer=foobar"){ [200, {}, nil] }
    client.bind('abcd123', 'foobar')
    stubs.verify_stubbed_calls
  end

  it "can create_anonymous using existing id" do
    stubs.put("anonymous/abcd123", %[{"user_agent":"Mozilla/5.0"}]){ [200, {}, nil] }
    id = client.create_anonymous(id: 'abcd123', user_agent: 'Mozilla/5.0')
    stubs.verify_stubbed_calls

    expect(id).to eq('abcd123')
  end

  it "can get_rankings" do
    stubs.get("rankings/anonymous=abcd123&entities=1001%2C%2C1002%2C%2C1003%2C%2C1004&entity_collection=products&ip=none&view=b%2Fmens-pants"){ [200, {}, %[{"ranking":["1004","1003","1002","1001"]}]] }
    rankings = client.get_rankings(
      id: 'abcd123',
      view: 'b/mens-pants',
      collection: 'products',
      entities: %w[1001, 1002, 1003, 1004]
    )
    stubs.verify_stubbed_calls

    expect(rankings).to eq(%W[1004 1003 1002 1001])
  end

  let(:req1){ CGI::escape 'anonymous=0cddbc0-6114-11e3-949a-0800200c9a66&view=b%2Fmens-pants&entity_collection=products&entities=1001%2C%2C1002%2C%2C1003%2C%2C1004&ip=none' }
  let(:req2){ CGI::escape 'anonymous=0cddbc0-6114-11e3-949a-0800200c9a66&view=b%2Fmens-pants&entity_collection=products&entities=2001%2C%2C2002%2C%2C2003%2C%2C2004&ip=none' }
  it "can multi_get_rankings" do
    stubs.get("/rankings?ids=anonymous%3D0cddbc0-6114-11e3-949a-0800200c9a66%26entities%3D1001%252C%252C1002%252C%252C1003%252C%252C1004%26entity_collection%3Dproducts%26ip%3Dnone%26view%3Db%252Fmens-pants&ids=anonymous%3D0cddbc0-6114-11e3-949a-0800200c9a66%26entities%3D2001%252C%252C2002%252C%252C2003%252C%252C2004%26entity_collection%3Dproducts%26ip%3Dnone%26view%3Db%252Fmens-pants") do
      [200, {}, <<-JSON]
{
    "errors": {},
    "results": {
        "anonymous=0cddbc0-6114-11e3-949a-0800200c9a66&entities=1001%2C%2C1002%2C%2C1003%2C%2C1004&entity_collection=products&ip=none&view=b%2Fmens-pants": {
            "ranking": [
                "1004",
                "1003",
                "1002",
                "1001"
            ]
        },
        "anonymous=0cddbc0-6114-11e3-949a-0800200c9a66&entities=2001%2C%2C2002%2C%2C2003%2C%2C2004&entity_collection=products&ip=none&view=b%2Fmens-pants": {
            "ranking": [
                "2004",
                "2003",
                "2002",
                "2001"
            ]
        }
    }
}
      JSON
    end
    rankings = client.multi_get_rankings([
      {
        id: '0cddbc0-6114-11e3-949a-0800200c9a66',
        view: 'b/mens-pants',
        collection: 'products',
        entities: %w[1001, 1002, 1003, 1004]
      },
      {
        id: '0cddbc0-6114-11e3-949a-0800200c9a66',
        view: 'b/mens-pants',
        collection: 'products',
        entities: %w[2001, 2002, 2003, 2004]
      }
    ])
    stubs.verify_stubbed_calls

    expect(rankings).to eq [
      %W[1004 1003 1002 1001],
      %W[2004 2003 2002 2001]
    ]
  end
end
