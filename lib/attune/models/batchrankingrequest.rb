module Attune
  module Model
    # 
    class BatchRankingRequest
      attr_accessor :requests
      

      def initialize(attributes = {})
        return if attributes.empty?
        # Morph attribute keys into undescored rubyish style
        if self.class.attribute_map[:"requests"]
          value = attributes["requests"] || attributes[:"requests"]
            if value.is_a?(Array)
              @requests = value.map{ |v| RankingParams.new(v) }

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
          :requests => :requests

        }
      end
    end
  end
end

