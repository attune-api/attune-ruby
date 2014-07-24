module Attune
  module Model
    # 
    #
    # @attr [String] id 
    # @attr [String] created_date 
    # @attr [String] updated_date 
    # @attr [String] entity_type 
    # @attr [String] end_date 
    # @attr [String] start_date 
    # @attr [String] consumer 
    # @attr [Array<String>] scope 
    # @attr [Array<String>] ids 
    # @attr [Boolean] disabled 
    class Blacklist
      attr_accessor :id
      

      attr_accessor :created_date
      

      attr_accessor :updated_date
      

      attr_accessor :entity_type
      

      attr_accessor :end_date
      

      attr_accessor :start_date
      

      attr_accessor :consumer
      

      attr_accessor :scope
      

      attr_accessor :ids
      

      attr_accessor :disabled
      

      def initialize(attributes = {})
        return if attributes.empty?
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @id = attributes["id"] || attributes[:"id"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @created_date = attributes["created_date"] || attributes[:"created_date"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @updated_date = attributes["updated_date"] || attributes[:"updated_date"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @entity_type = attributes["entity_type"] || attributes[:"entity_type"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @end_date = attributes["end_date"] || attributes[:"end_date"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @start_date = attributes["start_date"] || attributes[:"start_date"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @consumer = attributes["consumer"] || attributes[:"consumer"]
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
          :created_date => :created_date,
          :updated_date => :updated_date,
          :entity_type => :entity_type,
          :end_date => :end_date,
          :start_date => :start_date,
          :consumer => :consumer,
          :scope => :scope,
          :ids => :ids,
          :disabled => :disabled

        }
    end
  end
end

