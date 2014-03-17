require 'pry'
require 'spec_helper'

describe Attune::JsonLogger do
  let(:logger){ double(:logger) }
  let(:connection) do
    Faraday.new(url: 'http://example.com/') do |builder|
      builder.use described_class, logger
      builder.adapter :test do |stubs|
        stubs.get("/test"){ [200, {}, "foobar"] }
      end
    end
  end

  it "logs as expected" do
    logged = ""
    logger.stub(:info){|s| logged << s }

    Benchmark.stub(:realtime).and_yield.and_return(0.12)
    SecureRandom.stub(:uuid).and_return("eaa45af2-efc3-45ef-90da-9bcb56758e77")
    Time.stub(:now).and_return(12345)

    response = connection.get("/test")
    response.status.should == 200
    response.body.should == "foobar"

    expect(logged).to match(/{"ref":null,"v":1,"protocol":"http","host":"example.com","path":"\/test","t":12345000,"r_id":"eaa45af2-efc3-45ef-90da-9bcb56758e77","status":200,"ua":"Faraday v\d+.\d+.\d+","method":"get","perf":{"total":120.0}}/)
  end
end
