module Attune
  module Model
    # Wrapper for requesting multiple rankings in a single call.
    #
    # @attr [Array<Attune::Model::RankingParams>] requests
    class BatchRankingRequest
      attr_accessor :requests
      

      def initialize(attributes = {})
        return if attributes.empty?
        value = attributes["requests"] || attributes[:"requests"]
        if value.is_a?(Array)
          @requests = value.map{ |v| RankingParams.new(v) }

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
          :requests => :requests

        }
    end
  end
end

