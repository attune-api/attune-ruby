module Attune
  module Model
    # Inputs for ranking a set of ids for a particular user.
    #
    # @attr [String] customer 
    # @attr [String] entity_type 
    # @attr [String] view 
    # @attr [String] user_agent 
    # @attr [Array<String>] ids 
    # @attr [String] ip 
    # @attr [Array<Attune::Model::ScopeEntry>] scope 
    # @attr [String] anonymous 
    class RankingParams
      attr_accessor :customer
      

      attr_accessor :entity_type
      

      attr_accessor :view
      

      attr_accessor :user_agent
      

      attr_accessor :ids
      

      attr_accessor :ip
      

      attr_accessor :scope
      

      attr_accessor :anonymous
      

      def initialize(attributes = {})
        return if attributes.empty?
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @customer = attributes["customer"] || attributes[:"customer"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @entity_type = attributes["entityType"] || attributes[:"entity_type"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @view = attributes["view"] || attributes[:"view"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @user_agent = attributes["userAgent"] || attributes[:"user_agent"]
        value = attributes["ids"] || attributes[:"ids"]
        if value.is_a?(Array)
          @ids = value

        end
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @ip = attributes["ip"] || attributes[:"ip"]
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
          :customer => :customer,
          :entity_type => :entityType,
          :view => :view,
          :user_agent => :userAgent,
          :ids => :ids,
          :ip => :ip,
          :scope => :scope,
          :anonymous => :anonymous

        }
    end
  end
end

