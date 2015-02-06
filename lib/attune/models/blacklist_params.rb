module Attune
  module Model
    # 
    #
    # @attr [Array<Attune::Model::ScopeEntry>] scope 
    # @attr [String] active_from 
    # @attr [String] active_to 
    # @attr [String] entity_type 
    # @attr [Array<String>] ids 
    # @attr [Boolean] disabled 
    class BlacklistParams
      attr_accessor :scope
      

      attr_accessor :active_from
      

      attr_accessor :active_to
      

      attr_accessor :entity_type
      

      attr_accessor :ids
      

      attr_accessor :disabled
      

      def initialize(attributes = {})
        return if attributes.empty?
        value = attributes["scope"] || attributes[:"scope"]
        if value.is_a?(Array)
          @scope = value.map{ |v| ScopeEntry.new(v) }

        end
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @active_from = attributes["activeFrom"] || attributes[:"active_from"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @active_to = attributes["activeTo"] || attributes[:"active_to"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @entity_type = attributes["entityType"] || attributes[:"entity_type"]
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

