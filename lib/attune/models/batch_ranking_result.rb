module Attune
  module Model
    # Wrapper of multiple ranking results.
    #
    # @attr [Array<Attune::Model::RankedEntities>] results
    class BatchRankingResult
      attr_accessor :results
      

      def initialize(attributes = {})
        return if attributes.empty?
        value = attributes["results"] || attributes[:"results"]
        if value.is_a?(Array)
          @results = value.map{ |v| RankedEntities.new(v) }

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
          :results => :results

        }
    end
  end
end

