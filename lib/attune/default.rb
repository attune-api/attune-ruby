require "attune/call_dropping"
require "attune/json_logger"

module Attune
  # Default options
  module Default
    extend Configurable

    ENDPOINT = "http://localhost/".freeze

    MIDDLEWARE = Faraday::RackBuilder.new do |builder|
      # Log all requests
      builder.use Attune::CallDropping

      builder.request  :url_encoded

      # Allow one retry per request
      builder.request :retry, 1

      # Log all requests
      builder.use Attune::JsonLogger

      # Raise exceptions for HTTP 4xx/5xx
      builder.response :raise_error
      builder.adapter Faraday.default_adapter
    end

    configure do |c|
      c.endpoint = ENDPOINT
      c.middleware = MIDDLEWARE
      c.disabled = false
      c.exception_handler = :raise
      c.timeout = 1
    end
  end
end
