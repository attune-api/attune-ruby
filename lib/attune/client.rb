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
    attr_reader :entities
    attr_reader :anonymous
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
      @entities = Attune::Api::Entities.new(self)
      @anonymous = Attune::Api::Anonymous.new(self)
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

      params =  {client_id: client_id,
          client_secret: client_secret,
          grant_type: :client_credentials}
      response = post_form("oauth/token", params)
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

    def request(http_method, path, opts)
      adapter_method = adapter.method(http_method.downcase)
      adapter_method.call do |req|
        req.url path
        req.headers['Content-Type'] = 'application/json'
        req.headers['User-Agent'] = 'Attune RClient ' + Attune::VERSION
        req.headers.merge! opts[:headers] if opts[:headers]
        req.params = opts[:params] if opts[:params]
        req.body = ::JSON.dump(opts[:body]) if opts[:body]
      end
    rescue Errno::ENOENT, Faraday::Error::ClientError => e
      handle_exception(e)
    end

    def post_form(path, params={})
      adapter.post(path, params)
    rescue Errno::ENOENT, Faraday::Error::ClientError => e
      handle_exception(e)
    end

    def handle_exception e
      if exception_handler == :mock
        nil
      else
        if e.is_a? Errno::ENOENT
          raise Faraday::Error::ConnectionFailed, e
        elsif e.response && e.response[:status] == 401
          raise AuthenticationException, e
        else
          raise e
        end
      end
    end

    def adapter
      raise DisabledException if disabled?
      effective_middleware = middleware || default_middleware
      Faraday.new(url: endpoint, builder: effective_middleware, request: {timeout: timeout}) do |connection|
        connection.authorization :Bearer, auth_token unless !auth_token
      end
    end

    def default_middleware
      Faraday::Builder.new do |builder|
        # Needed for encoding of BATCH GET requests
        builder.use Attune::ParamFlattener

        builder.use Attune::CallDropping

        builder.request  :url_encoded

        builder.use Attune::JsonLogger, logger if logging_enabled

        # Gzip requests, Faraday handles responses automatically
        builder.use Attune::Gzip

        # Allow one retry per request
        builder.request :retry, 1

        # Raise exceptions for HTTP 4xx/5xx
        builder.response :raise_error

        builder.adapter :attune_http_persistent
      end
    end
  end
end

