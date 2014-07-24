module Attune
  module Model
    # 
    #
    # @attr [String] id 
    # @attr [String] entity_type 
    # @attr [String] consumer 
    # @attr [String] end_date 
    # @attr [Boolean] disabled 
    # @attr [String] created_at 
    # @attr [String] start_date 
    # @attr [Array<String>] scope 
    # @attr [Array<String>] ids 
    # @attr [Boolean] active 
    class Blacklist
      attr_accessor :id
      

      attr_accessor :entity_type
      

      attr_accessor :consumer
      

      attr_accessor :end_date
      

      attr_accessor :disabled
      

      attr_accessor :created_at
      

      attr_accessor :start_date
      

      attr_accessor :scope
      

      attr_accessor :ids
      

      attr_accessor :active
      

      def initialize(attributes = {})
        return if attributes.empty?
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @id = attributes["id"] || attributes[:"id"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @entity_type = attributes["entityType"] || attributes[:"entity_type"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @consumer = attributes["consumer"] || attributes[:"consumer"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @end_date = attributes["endDate"] || attributes[:"end_date"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @disabled = attributes["disabled"] || attributes[:"disabled"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @created_at = attributes["createdAt"] || attributes[:"created_at"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @start_date = attributes["startDate"] || attributes[:"start_date"]
        value = attributes["scope"] || attributes[:"scope"]
        if value.is_a?(Array)
          @scope = value

        end
        value = attributes["ids"] || attributes[:"ids"]
        if value.is_a?(Array)
          @ids = value

        end
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @active = attributes["active"] || attributes[:"active"]
        

      end

      def to_body
        Hash[ATTRIBUTE_MAP.map do |internal, external|
          next unless value = send(internal)
          [external, value]
        end.compact]
      end

      def to_json(options = {})
        to_body.to_json
      end

      private
      # :internal => :external
      ATTRIBUTE_MAP = {
          :id => :id,
          :entity_type => :entityType,
          :consumer => :consumer,
          :end_date => :endDate,
          :disabled => :disabled,
          :created_at => :createdAt,
          :start_date => :startDate,
          :scope => :scope,
          :ids => :ids,
          :active => :active

        }
    end
  end
end

