module Attune
  # Some code taken from a yet to be released version of faraday-middleware
  class Gzip < Faraday::Middleware
    dependency 'zlib'

    CONTENT_TYPE = 'Content-Type'.freeze
    CONTENT_ENCODING = 'Content-Encoding'.freeze
    MIME_TYPE    = 'application/json'.freeze
    ENCODING_TYPE = 'gzip'.freeze
    ACCEPT_ENCODING = 'Accept-Encoding'.freeze
    CONTENT_LENGTH = 'Content-Length'.freeze
    SUPPORTED_ENCODINGS = 'gzip,deflate'.freeze
    RUBY_ENCODING = '1.9'.respond_to?(:force_encoding)

    def call(env)
      if has_body?(env) && is_json?(env)
        wio = StringIO.new("w")
        w_gz = Zlib::GzipWriter.new(wio)
        w_gz.write env[:body]
        w_gz.close
        env[:body] = wio.string
        env[:request_headers][CONTENT_ENCODING] = ENCODING_TYPE
      end
      env[:request_headers][ACCEPT_ENCODING] ||= SUPPORTED_ENCODINGS
      @app.call(env).on_complete do |env|
        case env[:response_headers][CONTENT_ENCODING]
        when 'gzip'
          reset_body(env, &method(:uncompress_gzip))
        when 'deflate'
          reset_body(env, &method(:inflate))
        end
      end
    end
    def is_json?(env)
      env[:request_headers][CONTENT_TYPE] == MIME_TYPE
    end
    def has_body?(env)
      body = env[:body] and !(body.respond_to?(:to_str) and body.empty?)
    end

    def reset_body(env)
      env[:body] = yield(env[:body])
      env[:response_headers].delete(CONTENT_ENCODING)
      env[:response_headers][CONTENT_LENGTH] = env[:body].length
    end

    def uncompress_gzip(body)
      io = StringIO.new(body)
      gzip_reader = if RUBY_ENCODING
        Zlib::GzipReader.new(io, :encoding => 'ASCII-8BIT')
      else
        Zlib::GzipReader.new(io)
      end
      gzip_reader.read
    end
    def inflate(body)
      Zlib::Inflate.inflate(body)
    end
  end
end


