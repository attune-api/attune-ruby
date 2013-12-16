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
    stubs.get("rankings/anonymous=abcd123&view=b%2Fmens-pants&entity_collection=products&entities=1001%2C%2C1002%2C%2C1003%2C%2C1004&ip=none"){ [200, {}, %[{"ranking":["1004","1003","1002","1001"]}]] }
    rankings = client.get_rankings(
      id: 'abcd123',
      view: 'b/mens-pants',
      collection: 'products',
      entities: %w[1001, 1002, 1003, 1004]
    )
    stubs.verify_stubbed_calls

    expect(rankings).to eq(%W[1004 1003 1002 1001])
  end

  it "can multi_get_rankings" do
    stubs.get("/rankings?ids=anonymous%3D0cddbc0-6114-11e3-949a-0800200c9a66%26view%3Db%252Fmens-pants%26entity_collection%3Dproducts%26entities%3D1001%252C%252C1002%252C%252C1003%252C%252C1004%26ip%3Dnone&ids=anonymous%3D0cddbc0-6114-11e3-949a-0800200c9a66%26view%3Db%252Fmens-pants%26entity_collection%3Dproducts%26entities%3D2001%252C%252C2002%252C%252C2003%252C%252C2004%26ip%3Dnone") do
      [200, {}, %[{"results":{"fake0":{"ranking":["1004","1003","1002","1001"]},"fake1":{"ranking":["2004","2003","2002","2001"]}}}]]
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
