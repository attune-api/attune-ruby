require 'attune/param_flattener'
require "attune/call_dropping"
require "attune/json_logger"

module Attune
  # Default options
  module Default
    extend Configurable

    ENDPOINT = "http://localhost/".freeze

    MIDDLEWARE = Faraday::Builder.new do |builder|
      # Needed for encoding of BATCH GET requests
      builder.use Attune::ParamFlattener

      # Log all requests
      builder.use Attune::CallDropping

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
