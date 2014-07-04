module Attune
  module Model
    # 
    class BatchRankingResult
      attr_accessor :results
      

      def initialize(attributes = {})
        return if attributes.empty?
        # Morph attribute keys into undescored rubyish style
        if self.class.attribute_map[:"results"]
          value = attributes["results"] || attributes[:"results"]
            if value.is_a?(Array)
              @results = value.map{ |v| RankedEntities.new(v) }

            end
          end
        

      end

      def to_body
        body = {}
        self.class.attribute_map.each_pair do |key, value|
          body[value] = self.send(key) unless self.send(key).nil?
        end
        body
      end

      def to_json(options = {})
        to_body.to_json
      end

      private
      # :internal => :external
      def self.attribute_map
        {
          :results => :results

        }
      end
    end
  end
end

