require 'spec_helper'

describe Attune::CallDropping do
  let(:stubs){ Faraday::Adapter::Test::Stubs.new }
  let(:connection) do
    Faraday.new(url: 'http://example.com/') do |builder|
      builder.use described_class, storage
      builder.adapter :test, stubs
    end
  end
  let(:response){ connection.get("/") }

  context "without previous timeouts" do
    let(:storage){ {} }
    context "no timeout" do
      it "runs request" do
        stubs.get("/"){ [200, {}, "foobar"] }
        expect(response.body).to eq "foobar"
        expect(storage).to eq(skip_rate: 0.0)
      end
    end

    context "with a timeout" do
      let(:timeout){ Faraday::Error::TimeoutError.new("simulated timeout") }
      it "raises the timeout" do
        stubs.get("/"){ raise timeout }
        expect {
          response
        }.to raise_exception(Faraday::Error::TimeoutError)
        expect(storage).to eq(skip_rate: 0.25)
      end
    end
  end

  context "with an existing skip rate" do
    let(:storage){ {skip_rate: 1.0} }
    before{ described_class.any_instance.stub(rand: random) }
    context "request skipped" do
      let(:random){ 1 }
      it "raises timeout" do
        expect {
          response
        }.to raise_exception(Faraday::Error::TimeoutError)
        expect(storage).to eq(skip_rate: 1.00)
      end
    end
    context "request attempted" do
      let(:random){ 0 }
      it "succeeds an reduces skip rate" do
        stubs.get("/"){ [200, {}, "foobar"] }
        expect(response.body).to eq "foobar"
        expect(storage).to eq(skip_rate: 0.75)
      end
    end
  end
end
