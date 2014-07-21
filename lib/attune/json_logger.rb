require 'benchmark'
require 'securerandom'
require 'logger'

module Attune
  class JsonLogger < Faraday::Middleware
    def initialize app, logger=nil
      super(app)
      @logger = logger || Logger.new(STDERR)
    end
    def call(env)
      time = (Time.now.to_f * 1000).to_i
      response = nil
      elapsed_time = Benchmark.realtime do
        response = @app.call(env)
      end
      log(
        ref: nil,
        v: 1,
        protocol: env[:url].scheme,
        host: env[:url].host,
        path: env[:url].path,
        t: time,
        r_id: SecureRandom.uuid,
        status: response.status,
        ua: env[:request_headers]['User-Agent'],
        enc: env[:request_headers]['Content-Encoding'],
        method: env[:method],
        perf: {
          total: elapsed_time * 1000
        }
      )
      response
    end
    def log(data)
      @logger.info JSON.dump(data)
    end
  end
end

