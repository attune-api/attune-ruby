module Attune
  module Model
    # 
    class BlacklistParams
      attr_accessor :scope
      

      attr_accessor :active_from
      

      attr_accessor :active_to
      

      attr_accessor :entity_type
      

      attr_accessor :ids
      

      attr_accessor :disabled
      

      def initialize(attributes = {})
        return if attributes.empty?
        # Morph attribute keys into undescored rubyish style
        if self.class.attribute_map[:"scope"]
          value = attributes["scope"] || attributes[:"scope"]
            if value.is_a?(Array)
              @scope = value.map{ |v| String.new(v) }

            end
          end
        if self.class.attribute_map[:"active_from"]
          # Workaround since JSON.parse has accessors as strings rather than symbols
            @active_from = attributes["activeFrom"] || attributes[:"active_from"]
        end
        if self.class.attribute_map[:"active_to"]
          # Workaround since JSON.parse has accessors as strings rather than symbols
            @active_to = attributes["activeTo"] || attributes[:"active_to"]
        end
        if self.class.attribute_map[:"entity_type"]
          # Workaround since JSON.parse has accessors as strings rather than symbols
            @entity_type = attributes["entityType"] || attributes[:"entity_type"]
        end
        if self.class.attribute_map[:"ids"]
          value = attributes["ids"] || attributes[:"ids"]
            if value.is_a?(Array)
              @ids = value.map{ |v| String.new(v) }

            end
          end
        if self.class.attribute_map[:"disabled"]
          # Workaround since JSON.parse has accessors as strings rather than symbols
            @disabled = attributes["disabled"] || attributes[:"disabled"]
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
          :scope => :scope,
          :active_from => :activeFrom,
          :active_to => :activeTo,
          :entity_type => :entityType,
          :ids => :ids,
          :disabled => :disabled

        }
      end
    end
  end
end

