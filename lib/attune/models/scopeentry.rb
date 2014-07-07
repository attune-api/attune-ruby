module Attune
  module Model
    # Name value pairs indicating the context where a ranking will be displayed.
    #
    # @attr [String] name
    # @attr [String] value
    class ScopeEntry
      attr_accessor :name
      

      attr_accessor :value
      

      def initialize(attributes = {})
        return if attributes.empty?
        if self.class.attribute_map[:"name"]
          # Workaround since JSON.parse has accessors as strings rather than symbols
            @name = attributes["name"] || attributes[:"name"]
        end
        if self.class.attribute_map[:"value"]
          # Workaround since JSON.parse has accessors as strings rather than symbols
            @value = attributes["value"] || attributes[:"value"]
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
          :name => :name,
          :value => :value

        }
      end
    end
  end
end

