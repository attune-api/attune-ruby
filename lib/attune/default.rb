module Attune
  module Default
    extend Configurable

    ENDPOINT = "http://localhost/".freeze

    MIDDLEWARE = Faraday::Builder.new do |builder|
      builder.response :logger
      builder.response :raise_error
      builder.adapter Faraday.default_adapter
    end

    configure do |c|
      c.endpoint = ENDPOINT
      c.middleware = MIDDLEWARE
      c.disabled = false
    end
  end
end
