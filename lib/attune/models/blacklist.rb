module Attune
  module Model
    # 
    class Blacklist
      attr_accessor :id
      

      attr_accessor :ids
      

      attr_accessor :disabled
      

      attr_accessor :consumer
      

      attr_accessor :entity_type
      

      attr_accessor :start_date
      

      attr_accessor :end_date
      

      attr_accessor :created_at
      

      attr_accessor :scope
      

      def initialize(attributes = {})
        return if attributes.empty?
        # Morph attribute keys into undescored rubyish style
        if self.class.attribute_map[:"id"]
          # Workaround since JSON.parse has accessors as strings rather than symbols
            @id = attributes["id"] || attributes[:"id"]
        end
        if self.class.attribute_map[:"ids"]
          value = attributes["ids"] || attributes[:"ids"]
            if value.is_a?(Array)
              @ids = value

            end
          end
        if self.class.attribute_map[:"disabled"]
          # Workaround since JSON.parse has accessors as strings rather than symbols
            @disabled = attributes["disabled"] || attributes[:"disabled"]
        end
        if self.class.attribute_map[:"consumer"]
          # Workaround since JSON.parse has accessors as strings rather than symbols
            @consumer = attributes["consumer"] || attributes[:"consumer"]
        end
        if self.class.attribute_map[:"entity_type"]
          # Workaround since JSON.parse has accessors as strings rather than symbols
            @entity_type = attributes["entityType"] || attributes[:"entity_type"]
        end
        if self.class.attribute_map[:"start_date"]
          # Workaround since JSON.parse has accessors as strings rather than symbols
            @start_date = attributes["startDate"] || attributes[:"start_date"]
        end
        if self.class.attribute_map[:"end_date"]
          # Workaround since JSON.parse has accessors as strings rather than symbols
            @end_date = attributes["endDate"] || attributes[:"end_date"]
        end
        if self.class.attribute_map[:"created_at"]
          # Workaround since JSON.parse has accessors as strings rather than symbols
            @created_at = attributes["createdAt"] || attributes[:"created_at"]
        end
        if self.class.attribute_map[:"scope"]
          value = attributes["scope"] || attributes[:"scope"]
            if value.is_a?(Array)
              @scope = value

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
          :id => :id,
          :ids => :ids,
          :disabled => :disabled,
          :consumer => :consumer,
          :entity_type => :entityType,
          :start_date => :startDate,
          :end_date => :endDate,
          :created_at => :createdAt,
          :scope => :scope

        }
      end
    end
  end
end

