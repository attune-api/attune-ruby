module Attune
  module Model
    # Customer associated with an anonymous user
    class Customer
      attr_accessor :customer
      

      def initialize(attributes = {})
        return if attributes.empty?
        # Morph attribute keys into undescored rubyish style
        if self.class.attribute_map[:"customer"]
          # Workaround since JSON.parse has accessors as strings rather than symbols
            @customer = attributes["customer"] || attributes[:"customer"]
        end
        

      end

      # Return attributes of this model as a Hash
      # @return [Hash]
      def to_body
        body = {}
        self.class.attribute_map.each_pair do |key, value|
          body[value] = self.send(key) unless self.send(key).nil?
        end
        body
      end

      # Return attributes of this model as a JSON string
      # @return [String]
      def to_json(options = {})
        to_body.to_json
      end

      private
      # :internal => :external
      def self.attribute_map
        {
          :customer => :customer

        }
      end
    end
  end
end

