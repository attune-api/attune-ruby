module Attune
  module Model
    # 
    #
    # @attr [Array<Attune::Model::Blacklist>] blacklists
    class BlacklistGetResponse
      attr_accessor :blacklists
      

      def initialize(attributes = {})
        return if attributes.empty?
        value = attributes["blacklists"] || attributes[:"blacklists"]
        if value.is_a?(Array)
          @blacklists = value.map{ |v| Blacklist.new(v) }

        end
        

      end

      def to_body
        Hash[ATTRIBUTE_MAP.map do |internal, external|
          next unless value = send(internal)
          [external, value]
        end.compact]
      end

      def to_json(options = {})
        to_body.to_json
      end

      private
      # :internal => :external
      ATTRIBUTE_MAP = {
          :blacklists => :blacklists

        }
    end
  end
end

