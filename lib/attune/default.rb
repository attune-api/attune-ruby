require 'attune/param_flattener'
require "attune/call_dropping"
require "attune/json_logger"
require "attune/gzip"
require "attune/net_http_persistent"

module Attune
  # Default options
  module Default
    extend Configurable

    ENDPOINT = "https://api.attune-staging.co".freeze

    # user our version of NetHttpPersistent adapter
    Faraday::Adapter.register_middleware(attune_http_persistent: NetHttpPersistent)

    configure do |c|
      c.endpoint = ENDPOINT
      c.disabled = false
      c.exception_handler = :raise
      c.timeout = 1
    end
  end
end

