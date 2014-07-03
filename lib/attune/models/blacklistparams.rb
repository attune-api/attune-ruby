module Attune
  module Model
    # 
    class BlacklistParams
      attr_accessor :entity_type
      

      attr_accessor :disabled
      

      attr_accessor :ids
      

      attr_accessor :scope
      

      attr_accessor :active_from
      

      attr_accessor :active_to
      

      # :internal => :external
      def self.attribute_map
        {
          :entity_type => :entityType,
          :disabled => :disabled,
          :ids => :ids,
          :scope => :scope,
          :active_from => :activeFrom,
          :active_to => :activeTo

        }
      end

      def initialize(attributes = {})
        return if attributes.empty?
        # Morph attribute keys into undescored rubyish style
        if self.class.attribute_map[:"entity_type"]
          # Workaround since JSON.parse has accessors as strings rather than symbols
            @entity_type = attributes["entityType"] || attributes[:"entity_type"]
        end
        if self.class.attribute_map[:"disabled"]
          # Workaround since JSON.parse has accessors as strings rather than symbols
            @disabled = attributes["disabled"] || attributes[:"disabled"]
        end
        if self.class.attribute_map[:"ids"]
          value = attributes["ids"] || attributes[:"ids"]
            if value.is_a?(Array)
              @ids = value

            end
          end
        if self.class.attribute_map[:"scope"]
          value = attributes["scope"] || attributes[:"scope"]
            if value.is_a?(Array)
              @scope = value

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

