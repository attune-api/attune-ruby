require 'json'

module Attune
  class Client
    include Attune::Configurable

    def initialize options={}
      Attune::Configurable::KEYS.each do |key|
        send("#{key}=", options[key] || Attune::Default.send(key))
      end
    end

    def create_anonymous options
      raise ArgumentError, "user_agent required" unless options[:user_agent]
      if id = options[:id]
        response = put("anonymous/#{id}", {user_agent: options[:user_agent]})
        id
      else
        response = post("anonymous", {user_agent: options[:user_agent]})
        response[:location][/\Aurn:id:([a-z0-9\-]+)\Z/, 1]
      end
    end

    def get_rankings options
      qs = encoded_ranking_params(options)
      response = get("rankings/#{qs}", customer: options.fetch(:customer, 'none'))
      JSON.parse(response.body)['ranking']
    end

    def multi_get_rankings multi_options
      requests = multi_options.map do |options|
        encoded_ranking_params(options)
      end
      response = get("rankings", ids: requests)
      results = JSON.parse(response.body)['results']
      results.values.map do |result|
        result['ranking']
      end
    end

    def bind id, customer_id
      put("bindings/anonymous=#{id}&customer=#{customer_id}")
      true
    end

    private
    def encoded_ranking_params options
      params = {
        anonymous: options.fetch(:id),
        view: options.fetch(:view),
        entity_collection: options.fetch(:collection),
        entities: options.fetch(:entities).join(','),
        ip: options.fetch(:ip, 'none')
      }
      Faraday::Utils::ParamsHash[params].to_query
    end

    def get path, params={}
      adapter.get(path, params)
    end
    def put path, params={}
      adapter.put(path, ::JSON.dump(params))
    end
    def post path, params={}
      adapter.post(path, ::JSON.dump(params))
    end
    def adapter
      Faraday.new(url: endpoint, builder: middleware)
    end
  end
end
