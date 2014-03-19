require 'json'

module Attune
  class DisabledException < Faraday::Error::ClientError
    def initialize(message="Attune library disabled though config")
      super(message)
    end
  end

  class AuthenticationException < Faraday::Error::ClientError
    def initialize(message="Authentication credentials not accepted")
      super(message)
    end
  end

  class Client
    include Attune::Configurable

    # Initializes a new Client
    #
    # @example
    #   client = Attune::Client.new(
    #     endpoint: "http://example.com:8080/",
    #     timeout:  10
    #   )
    #
    # @param [Hash] options Options for connection (see Attune::Configurable)
    # @return A new client object
    def initialize(options={})
      Attune::Configurable::KEYS.each do |key|
        send("#{key}=", options[key] || Attune::Default.send(key))
      end
    end

    # Request an auth token
    #
    # @example Generate a new auth token
    #   token = client.get_auth_token("client id", "secret")
    # @param [String] client_id The client identifier.
    # @param [String] client_secret The secret key for the client.
    # @return An auth token if credentials accepted
    # @raise [ArgumentError] if client_id or client_secret is not provided
    # @raise [AuthenticationException] if client_id or client_secret are not accepted
    # @raise [Faraday::Error::ClientError] if the request fails or exceeds the timeout
    def get_auth_token(client_id, client_secret)
      raise ArgumentError, "client_id required" unless client_id
      raise ArgumentError, "client_secret required" unless client_secret

      response = post_form("oauth/token",
        client_id: client_id,
        client_secret: client_secret,
        grant_type: :client_credentials
      )
      if response
        body = JSON.parse(response.body)
        if body['error']
          raise AuthenticationException, body['error_description']
        end
        body['access_token']
      else
        # Return a new UUID if there was an exception and we're in mock mode
        SecureRandom.uuid
      end
    end

    # Create an anonymous tracked user
    #
    # @example Generate a new id (preferred)
    #   anonymous_id = client.create_anonymous(
    #     user_agent: 'Mozilla/5.0'
    #   )
    # @example Create using an existing id
    #   client.create_anonymous(
    #     id: '0cddbc0-6114-11e3-949a-0800200c9a66',
    #     user_agent: 'Mozilla/5.0'
    #   )
    # @param [Hash] options
    # @option options [String] :id optional. An id will be generated if this is not provided
    # @option options [String] :user_agent The user agent for the application used by the anonymous users
    # @return id [String]
    # @raise [ArgumentError] if user_agent is not provided
    # @raise [Faraday::Error::ClientError] if the request fails or exceeds the timeout
    # @raise [AuthenticationException] if authorization header not accepted
    def create_anonymous(options)
      raise ArgumentError, "user_agent required" unless options[:user_agent]
      if id = options[:id]
        put("anonymous/#{id}", {user_agent: options[:user_agent]})
        id
      else
        if response = post_json("anonymous", {user_agent: options[:user_agent]})
          response[:location][/\Aurn:id:([a-z0-9\-]+)\Z/, 1]
        else
          # Return a new UUID if there was an exception and we're in mock mode
          SecureRandom.uuid
        end
      end
    end

    # Returns all entities from the specified collection in order of the user's preference
    #
    # @example
    #   rankings = client.get_rankings(
    #     id: '0cddbc0-6114-11e3-949a-0800200c9a66',
    #     view: 'b/mens-pants',
    #     collection: 'products',
    #     entities: %w[1001, 1002, 1003, 1004]
    #   )
    # @param [Hash] options
    # @option options [String] :id The anonymous user id for whom to grab rankings
    # @option options [String] :view The page or app URN on which the entities will be displayed
    # @option options [String] :collection name of the collection of entities
    # @option options [Array<String>] :entities entities to be ranked. These should be numeric strings or integers.
    # @option options [String] :ip ip address of remote user. Used for geolocation (optional)
    # @option options [String] :customer id of customer (optional)
    # @return ranking [Array<String>] The entities in their ranked order
    # @raise [ArgumentError] if required parameters are missing
    # @raise [Faraday::Error::ClientError] if the request fails or exceeds the timeout
    # @raise [AuthenticationException] if authorization header not accepted
    def get_rankings(options)
      qs = encoded_ranking_params(options)
      if response = get("rankings/#{qs}", customer: options.fetch(:customer, 'none'))
        JSON.parse(response.body)['ranking']
      else
        # In mock mode: return the entities in the order passed in
        options[:entities]
      end
    end

    # Get multiple rankings in one call
    #
    # @example
    #   rankings = client.multi_get_rankings([
    #     {
    #       id: '0cddbc0-6114-11e3-949a-0800200c9a66',
    #       view: 'b/mens-pants',
    #       collection: 'products',
    #       entities: %w[1001, 1002, 1003, 1004]
    #     },
    #     {
    #       id: '0cddbc0-6114-11e3-949a-0800200c9a66',
    #       view: 'b/mens-pants',
    #       collection: 'products',
    #       entities: %w[2001, 2002, 2003, 2004]
    #     }
    #   ])
    # @param [Array<Hash>] multi_options An array of options (see #get_rankings)
    # @return [Array<Array<String>>] rankings
    # @raise [Faraday::Error::ClientError] if the request fails or exceeds the timeout
    # @raise [AuthenticationException] if authorization header not accepted
    def multi_get_rankings(multi_options)
      requests = multi_options.map do |options|
        encoded_ranking_params(options)
      end
      if response = get("rankings", ids: requests)
        results = JSON.parse(response.body)['results']

        # Order of encoded paramaters may change, so we must parse them
        results = Hash[results.map do |request, result|
          [CGI.parse(request), result]
        end]
        requests.map do |request|
          results[CGI.parse(request)]['ranking']
        end
      else
        # In mock mode: return the entities in the order passed in
        multi_options.map do |options|
          options[:entities]
        end
      end
    end

    # Binds an anonymous user to a customer id
    #
    # @param [String] id The anonymous visitor to bind
    # @param [String] customer_id The customer id to bind
    # @example
    #   rankings = client.bind(
    #     '25892e17-80f6-415f-9c65-7395632f022',
    #     'cd171f7c-560d-4a62-8d65-16b87419a58'
    #   )
    # @raise [Faraday::Error::ClientError] if the request fails or exceeds the timeout
    # @raise [AuthenticationException] if authorization header not accepted
    def bind(id, customer_id)
      put("bindings/anonymous=#{id}&customer=#{customer_id}")
      true
    end

    private
    def encoded_ranking_params(options)
      params = {
        anonymous: options.fetch(:id),
        view: options.fetch(:view),
        entity_collection: options.fetch(:collection),
        entities: options.fetch(:entities).join(','),
        ip: options.fetch(:ip, 'none')
      }
      Faraday::Utils::ParamsHash[params].to_query
    end

    def get(path, params={})
      adapter.get(path, params)
    rescue Faraday::Error::ClientError => e
      handle_exception(e)
    end

    def put(path, params={})
      adapter.put(path, ::JSON.dump(params))
    rescue Faraday::Error::ClientError => e
      handle_exception(e)
    end

    def post_form(path, params={})
      adapter.post(path, params)
    rescue Faraday::Error::ClientError => e
      handle_exception(e)
    end

    def post_json(path, params={})
      adapter.post do |req|
        req.url path
        req.headers['Content-Type'] = 'application/json'
        req.body = ::JSON.dump(params)
      end
    rescue Faraday::Error::ClientError => e
      handle_exception(e)
    end

    def handle_exception e
      if exception_handler == :mock
        nil
      else
        if e.response && e.response[:status] == 401
          raise AuthenticationException, e
        else
          raise e
        end
      end
    end

    def adapter
      raise DisabledException if disabled?
      Faraday.new(url: endpoint, builder: middleware) do |connection|
        connection.options.timeout = timeout

        # Needed for encoding of BATCH GET requests
        connection.options.params_encoder = Faraday::FlatParamsEncoder

        connection.authorization :Bearer, auth_token unless !auth_token
      end
    end
  end
end
