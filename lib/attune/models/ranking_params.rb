module Attune
  module Model
    # Inputs for ranking a set of ids for a particular user.
    #
    # @attr [String] user_agent 
    # @attr [String] ip 
    # @attr [Array<String>] ids 
    # @attr [String] view 
    # @attr [String] entity_type 
    # @attr [String] customer 
    # @attr [Array<Attune::Model::ScopeEntry>] scope 
    # @attr [String] anonymous 
    class RankingParams
      attr_accessor :user_agent
      

      attr_accessor :ip
      

      attr_accessor :ids
      

      attr_accessor :view
      

      attr_accessor :entity_type
      

      attr_accessor :customer
      

      attr_accessor :scope
      

      attr_accessor :anonymous
      

      def initialize(attributes = {})
        return if attributes.empty?
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @user_agent = attributes["userAgent"] || attributes[:"user_agent"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @ip = attributes["ip"] || attributes[:"ip"]
        value = attributes["ids"] || attributes[:"ids"]
        if value.is_a?(Array)
          @ids = value

        end
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @view = attributes["view"] || attributes[:"view"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @entity_type = attributes["entityType"] || attributes[:"entity_type"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @customer = attributes["customer"] || attributes[:"customer"]
        value = attributes["scope"] || attributes[:"scope"]
        if value.is_a?(Array)
          @scope = value.map{ |v| ScopeEntry.new(v) }

        end
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @anonymous = attributes["anonymous"] || attributes[:"anonymous"]
        

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
          :user_agent => :userAgent,
          :ip => :ip,
          :ids => :ids,
          :view => :view,
          :entity_type => :entityType,
          :customer => :customer,
          :scope => :scope,
          :anonymous => :anonymous

        }
    end
  end
end

