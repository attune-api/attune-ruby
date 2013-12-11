module Attune
  module Configurable
    KEYS = [
      :endpoint,
      :middleware,
      :disabled,
      :timeout
    ]

    attr_accessor *KEYS

    def configure
      yield self
    end
  end
end
