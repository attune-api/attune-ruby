module Attune
  module Model
    # 
    #
    # @attr [String] id
    # @attr [Array<string>] ids
    # @attr [Boolean] disabled
    # @attr [Array<string>] scope
    # @attr [String] consumer
    # @attr [String] entity_type
    # @attr [String] start_date
    # @attr [String] end_date
    # @attr [String] created_at
    class Blacklist
      attr_accessor :id
      

      attr_accessor :ids
      

      attr_accessor :disabled
      

      attr_accessor :scope
      

      attr_accessor :consumer
      

      attr_accessor :entity_type
      

      attr_accessor :start_date
      

      attr_accessor :end_date
      

      attr_accessor :created_at
      

      def initialize(attributes = {})
        return if attributes.empty?
        if self.class.attribute_map[:"id"]
          # Workaround since JSON.parse has accessors as strings rather than symbols
            @id = attributes["id"] || attributes[:"id"]
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
        if self.class.attribute_map[:"scope"]
          value = attributes["scope"] || attributes[:"scope"]
            if value.is_a?(Array)
              @scope = value.map{ |v| String.new(v) }

            end
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
          :scope => :scope,
          :consumer => :consumer,
          :entity_type => :entityType,
          :start_date => :startDate,
          :end_date => :endDate,
          :created_at => :createdAt

        }
      end
    end
  end
end

