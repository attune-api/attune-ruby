module Attune
  class Client
    include Attune::Configurable

    def initialize options={}
      Attune::Configurable::KEYS.each do |key|
        send("#{key}=", options[key] || Attune::Default.send(key))
      end
    end
  end
end
