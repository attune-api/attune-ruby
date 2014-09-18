require 'spec_helper'

describe "remote requests" do
  let(:endpoint){ ENV['REMOTE_ENDPOINT'] }
  let(:auth_token){ ENV['AUTH_TOKEN'] }

  let(:client_id) { ENV['CLIENT_ID'] }
  let(:client_secret) { ENV['CLIENT_SECRET'] }

  before do
    pending "REMOTE_ENDPOINT required for remote spec" unless endpoint
    pending "AUTH_TOKEN required for remote spec" unless auth_token
  end
  let!(:client){ Attune::Client.new(endpoint: endpoint, auth_token: auth_token, timeout: 20) }

  it "can request an auth_token given a client id and secret" do
    pending "CLIENT_ID required for get_auth_token spec" unless client_id
    pending "CLIENT_SECRET required for get_auth_token spec" unless client_secret
    token = client.get_auth_token(client_id, client_secret)
    token.should =~ /[a-z0-9\-]+/
  end

  it "can create an anonymous user" do
    result = client.anonymous.create
    result.id.should =~ /[a-z0-9\-]+/
  end

  it "can bind and get an anonymous user" do
    client.anonymous.update('654321', Attune::Model::Customer.new(customer:'foobar'))
    customer = client.anonymous.get('654321')
    customer.customer.should == 'foobar'
  end

  let(:entities){ [202875,202876,202874,202900,202902,202898,202905,200182,200181,185940,188447,185932,190589,1238689589] }
  describe "get_rankings" do
    before(:each) do
      anonymous_result = client.anonymous.create
      params = Attune::Model::RankingParams.new
      params.anonymous = anonymous_result.id
      params.view = 'b/mens-pants'
      params.entity_type = 'products'
      params.ids = entities
      @result = client.entities.get_rankings(params)
    end
    it "can get ranked entities" do
      @result.ranking.should be_an Array
      @result.ranking.sort.should == entities.map(&:to_s).sort
    end
  end

  describe "multi_get_rankings" do
    before(:each) do
      anonymous_result = client.anonymous.create
      params = Attune::Model::RankingParams.new
      params.anonymous = anonymous_result.id
      params.view = 'b/mens-pants'
      params.entity_type = 'products'
      params.ids = entities
      batch_request = Attune::Model::BatchRankingRequest.new
      batch_request.requests = [params]
      @results = client.entities.batch_get_rankings(batch_request)
    end
    it "can batch get rankings" do
      @results.results.should be_an Array
      ranking = @results.results[0].ranking
      ranking.sort.should == entities.map(&:to_s).sort
    end
  end

  it 'should call blacklist api' do
    # create
    params = Attune::Model::BlacklistParams.new
    params.ids = [1,2,3]
    params.entity_type = 'products'
    scope = Attune::Model::ScopeEntry.new
    scope.name = 'page'
    scope.value = 'sale'
    params.scope = [scope]
    params.active_from = DateTime.now
    params.active_to = DateTime.now + 7
    response = client.entities.blacklist_save(params)
    blacklist_id = response.id
    blacklist_id.should match(/^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i)
    # get
    blacklist = client.entities.blacklist_get(blacklist_id)
    blacklist.id.should == blacklist_id
    # update
    params = Attune::Model::BlacklistParams.new
    params.disabled = true
    params.entity_type = 'products'
    client.entities.blacklist_update(blacklist_id, params)
    blacklist = client.entities.blacklist_get(blacklist_id)
    blacklist.disabled.should == true
    # get all
    all_blacklists = client.entities.blacklist_get_all()
    all_blacklists.blacklists.should be_an Array
    # delete
    client.entities.blacklist_delete(blacklist_id)
  end
end
