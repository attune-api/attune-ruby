# Hack NetHttpPersistent adapter to allow passing for env options
# We need this so we can pass in an option for idle_timout, until
# this is resolved https://github.com/lostisland/faraday/issues/262

module Attune
  class NetHttpPersistent < Faraday::Adapter::NetHttpPersistent

    def net_http_connection(env)
      adapter = super
      adapter.idle_timeout = 58 # seconds
      adapter
    end

  end
end

