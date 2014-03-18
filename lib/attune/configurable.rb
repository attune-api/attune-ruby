module Attune
  module Configurable
    KEYS = [
      :auth_token,
      :endpoint,
      :middleware,
      :disabled,
      :exception_handler,
      :timeout
    ]

    # The Authorization token
    attr_accessor :auth_token

    # The HTTP endpoint to connect to
    attr_accessor :endpoint

    # Middleware used by faraday
    attr_accessor :middleware

    # FIXME
    attr_accessor :disabled
    alias_method :disabled?, :disabled

    # Time (in seconds) to wait for requests to finish
    attr_accessor :timeout

    # How to deal with HTTP exceptions
    # @param [:mock, :raise] handler Method used for handling exceptions.
    # @raise [ArgumentError] if handler is not :mock or :raise
    attr_reader :exception_handler
    def exception_handler= handler
      if [:mock, :raise].include?(handler)
        @exception_handler = handler
      else
        raise ArgumentError, "exception_handler must be :mock or :raise"
      end
    end

    # @example configure
    #   Attune.configure do |c|
    #     c.endpoint = "http://example.com:8080/"
    #     c.timeout  = 5
    #   end
    def configure
      yield self
    end
  end
end
