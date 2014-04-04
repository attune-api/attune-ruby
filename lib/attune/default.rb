require 'attune/param_flattener'
require "attune/call_dropping"
require "attune/json_logger"
require "attune/net_http_persistent"

module Attune
  # Default options
  module Default
    extend Configurable

    ENDPOINT = "http://localhost/".freeze

    # user our version of NetHttpPersistent adapter
    Faraday::Adapter.register_middleware(attune_http_persistent: NetHttpPersistent)

    MIDDLEWARE = Faraday::Builder.new do |builder|
      # Needed for encoding of BATCH GET requests
      builder.use Attune::ParamFlattener

      # Log all requests
      builder.use Attune::CallDropping

      builder.request  :url_encoded

      # Allow one retry per request
      builder.request :retry, 1

      # Log all requests
      builder.use Attune::JsonLogger

      # Raise exceptions for HTTP 4xx/5xx
      builder.response :raise_error

      builder.adapter :attune_http_persistent
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
