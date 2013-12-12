class ParamFlattener < Faraday::Middleware
  def call(env)
    url = env[:url]

    # replaces ?foo[]=123 with ?foo=123
    url.query = url.query.gsub('%5B%5D', '') if url.query

    @app.call(env)
  end
end
