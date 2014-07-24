module Attune
  module Model
    # 
    #
    # @attr [String] id 
    # @attr [String] entity_type 
    # @attr [String] consumer 
    # @attr [String] start_date 
    # @attr [String] created_date 
    # @attr [String] updated_date 
    # @attr [String] end_date 
    # @attr [Array<String>] scope 
    # @attr [Array<String>] ids 
    # @attr [Boolean] disabled 
    class Blacklist
      attr_accessor :id
      

      attr_accessor :entity_type
      

      attr_accessor :consumer
      

      attr_accessor :start_date
      

      attr_accessor :created_date
      

      attr_accessor :updated_date
      

      attr_accessor :end_date
      

      attr_accessor :scope
      

      attr_accessor :ids
      

      attr_accessor :disabled
      

      def initialize(attributes = {})
        return if attributes.empty?
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @id = attributes["id"] || attributes[:"id"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @entity_type = attributes["entityType"] || attributes[:"entity_type"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @consumer = attributes["consumer"] || attributes[:"consumer"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @start_date = attributes["startDate"] || attributes[:"start_date"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @created_date = attributes["createdDate"] || attributes[:"created_date"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @updated_date = attributes["updatedDate"] || attributes[:"updated_date"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @end_date = attributes["endDate"] || attributes[:"end_date"]
        value = attributes["scope"] || attributes[:"scope"]
        if value.is_a?(Array)
          @scope = value

        end
        value = attributes["ids"] || attributes[:"ids"]
        if value.is_a?(Array)
          @ids = value

        end
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @disabled = attributes["disabled"] || attributes[:"disabled"]
        

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
          :start_date => :startDate,
          :created_date => :createdDate,
          :updated_date => :updatedDate,
          :end_date => :endDate,
          :scope => :scope,
          :ids => :ids,
          :disabled => :disabled

        }
    end
  end
end

