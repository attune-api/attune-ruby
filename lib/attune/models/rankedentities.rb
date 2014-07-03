module Attune
  module Model
    # 
    class RankedEntities
      attr_accessor :message
      

      attr_accessor :status
      

      attr_accessor :ranking
      

      # :internal => :external
      def self.attribute_map
        {
          :message => :message,
          :status => :status,
          :ranking => :ranking

        }
      end

      def initialize(attributes = {})
        return if attributes.empty?
        # Morph attribute keys into undescored rubyish style
        if self.class.attribute_map[:"message"]
          # Workaround since JSON.parse has accessors as strings rather than symbols
            @message = attributes["message"] || attributes[:"message"]
        end
        if self.class.attribute_map[:"status"]
          # Workaround since JSON.parse has accessors as strings rather than symbols
            @status = attributes["status"] || attributes[:"status"]
        end
        if self.class.attribute_map[:"ranking"]
          value = attributes["ranking"] || attributes[:"ranking"]
            if value.is_a?(Array)
              @ranking = value

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
    end
  end
end

