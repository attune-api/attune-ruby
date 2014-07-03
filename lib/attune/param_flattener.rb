module Attune
  # Faraday 0.8 can't make resuests like /?ids=123&ids=456 and forces the form
  # /?ids[]=123&ids[]=456 (this is fixed in faraday 0.9)
  #
  # Fortunately faraday's middleware is quite powerful. This just strips the
  # array syntax from the request.
  class ParamFlattener < Faraday::Middleware
    def call(env)
      url = env[:url]

      # replaces ?foo[]=123 with ?foo=123
      url.query = url.query.gsub('%5B%5D', '') if url.query

      @app.call(env)
    end
  end
end

