module Attune
  module Model
    # 
    class BlacklistSaveResponse
      attr_accessor :result
      

      # :internal => :external
      def self.attribute_map
        {
          :result => :result

        }
      end

      def initialize(attributes = {})
        return if attributes.empty?
        # Morph attribute keys into undescored rubyish style
        if self.class.attribute_map[:"result"]
          # Workaround since JSON.parse has accessors as strings rather than symbols
            @result = attributes["result"] || attributes[:"result"]
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
    end
  end
end

