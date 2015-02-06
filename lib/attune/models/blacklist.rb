module Attune
  module Model
    # 
    #
    # @attr [String] id 
    # @attr [Array<String>] ids 
    # @attr [String] consumer 
    # @attr [String] entity_type 
    # @attr [String] start_date 
    # @attr [String] end_date 
    # @attr [String] scope 
    # @attr [Boolean] disabled 
    # @attr [String] created_date 
    # @attr [String] updated_date 
    class Blacklist
      attr_accessor :id
      

      attr_accessor :ids
      

      attr_accessor :consumer
      

      attr_accessor :entity_type
      

      attr_accessor :start_date
      

      attr_accessor :end_date
      

      attr_accessor :scope
      

      attr_accessor :disabled
      

      attr_accessor :created_date
      

      attr_accessor :updated_date
      

      def initialize(attributes = {})
        return if attributes.empty?
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @id = attributes["id"] || attributes[:"id"]
        value = attributes["ids"] || attributes[:"ids"]
        if value.is_a?(Array)
          @ids = value

        end
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @consumer = attributes["consumer"] || attributes[:"consumer"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @entity_type = attributes["entityType"] || attributes[:"entity_type"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @start_date = attributes["startDate"] || attributes[:"start_date"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @end_date = attributes["endDate"] || attributes[:"end_date"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @scope = attributes["scope"] || attributes[:"scope"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @disabled = attributes["disabled"] || attributes[:"disabled"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @created_date = attributes["createdDate"] || attributes[:"created_date"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @updated_date = attributes["updatedDate"] || attributes[:"updated_date"]
        

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
          :ids => :ids,
          :consumer => :consumer,
          :entity_type => :entityType,
          :start_date => :startDate,
          :end_date => :endDate,
          :scope => :scope,
          :disabled => :disabled,
          :created_date => :createdDate,
          :updated_date => :updatedDate

        }
    end
  end
end

