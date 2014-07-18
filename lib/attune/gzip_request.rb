module Attune
  class GzipRequest < Faraday::Middleware
    CONTENT_TYPE = 'Content-Type'.freeze
    CONTENT_ENCODING = 'Content-Encoding'.freeze
    MIME_TYPE    = 'application/json'.freeze
    ENCODING_TYPE = 'gzip'.freeze

    def call(env)
      if has_body?(env) && is_json?(env)
        wio = StringIO.new("w")
        w_gz = Zlib::GzipWriter.new(wio)
        w_gz.write env[:body]
        w_gz.close
        env[:body] = wio.string
        env[:request_headers][CONTENT_ENCODING] = ENCODING_TYPE
      end
      @app.call env
    end
    def is_json?(env)
      env[:request_headers][CONTENT_TYPE] == MIME_TYPE
    end
    def has_body?(env)
      body = env[:body] and !(body.respond_to?(:to_str) and body.empty?)
    end
  end
end

