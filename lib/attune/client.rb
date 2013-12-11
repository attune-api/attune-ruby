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
      params = {
        anonymous: options.fetch(:id),
        view: options.fetch(:view),
        entity_collection: options.fetch(:collection),
        entities: options.fetch(:entities).join(','),
        ip: options.fetch(:ip, 'none')
      }
      qs = Faraday::Utils::ParamsHash[params].to_query
      response = get("rankings/#{qs}", customer: options.fetch(:customer, 'none'))
      JSON.parse(response.body)['ranking']
    end

    def bind id, customer_id
      put("bindings/anonymous=#{id}&customer=#{customer_id}")
      true
    end

    private
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
