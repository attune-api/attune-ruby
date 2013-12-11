require 'spec_helper'

describe "remote requests" do
  let(:endpoint){ ENV['REMOTE_ENDPOINT'] }
  before { pending "REMOTE_ENDPOINT required for remote spec" unless endpoint }
  let!(:client){ Attune::Client.new(endpoint: endpoint) }

  it "can create an anonymous user" do
    id = client.create_anonymous(user_agent: 'Mozilla/5.0')
    id.should =~ /[a-z0-9\-]+/
  end

  it "can create an anonymous user with an id" do
    id = client.create_anonymous(id: '123456', user_agent: 'Mozilla/5.0')
    id.should == '123456'
  end

  it "can bind an anonymous user" do
    id = client.create_anonymous(id: '123456', user_agent: 'Mozilla/5.0')
    client.bind(id, '654321')
  end

  describe "get_rankings" do
    let(:entities){ [202875,202876,202874,202900,202902,202898,202905,200182,200181,185940,188447,185932,190589,1238689589] }
    it "can get rankings" do
      id = client.create_anonymous(id: '123456', user_agent: 'Mozilla/5.0')
      client.bind(id, '654321')
      result = client.get_rankings(id: '123456', view: 'b/mens-pants', collection: 'products', entities: entities)
      result.should be_an Array
      result.sort.should == entities.map(&:to_s).sort
    end
  end
end
