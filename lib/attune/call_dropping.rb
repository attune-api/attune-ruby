module Attune
  class CallDropping < Faraday::Middleware
    def initialize app, storage=default_storage
      @app = app
      @storage = storage
    end

    def call env
      raise_timeout if should_skip?
      begin
        result = @app.call(env)
        increment_skips(-SKIP_STEP)
        result
      rescue Faraday::Error::TimeoutError => e
        increment_skips(SKIP_STEP)
        raise e
      end
    end

    private
    # requests to skip before retry
    SKIP_STEP = 0.25

    # The most requests to skip before retrying
    SKIP_MAX = 10.0

    def raise_timeout
      raise Faraday::Error::TimeoutError, "dropped request"
    end

    def should_skip?
      rand > (1.0 / (1.0 + skip_rate))
    end

    def increment_skips amount
      self.skip_rate = skip_rate + amount

      if skip_rate <= 0.0
        self.skip_rate = 0.0
      elsif skip_rate >= SKIP_MAX
        self.skip_rate = SKIP_MAX
      end
    end

    def skip_rate; @storage[:skip_rate] || 0.0; end
    def skip_rate= v; @storage[:skip_rate]= v; end

    def default_storage
      Thread.current
    end
  end
end

