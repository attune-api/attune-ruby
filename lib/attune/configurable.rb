module Attune
  module Configurable
    KEYS = [
      :endpoint,
      :middleware,
      :disabled,
      :timeout
    ]

    # The HTTP endpoint to connect to
    attr_accessor :endpoint

    # Middleware used by faraday
    attr_accessor :middleware

    # FIXME
    attr_accessor :disabled

    # Time (in seconds) to wait for requests to finish
    attr_accessor :timeout

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
