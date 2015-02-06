module Attune
  module Model
    # Inputs for ranking a set of ids for a particular user.
    #
    # @attr [String] user_agent 
    # @attr [String] ip 
    # @attr [Array<Attune::Model::ScopeEntry>] scope 
    # @attr [String] anonymous 
    # @attr [String] entity_type 
    # @attr [Array<String>] ids 
    # @attr [String] customer 
    # @attr [Array<Attune::Model::int>] quantities 
    # @attr [String] application 
    # @attr [String] view 
    class RankingParams
      attr_accessor :user_agent
      

      attr_accessor :ip
      

      attr_accessor :scope
      

      attr_accessor :anonymous
      

      attr_accessor :entity_type
      

      attr_accessor :ids
      

      attr_accessor :customer
      

      attr_accessor :quantities
      

      attr_accessor :application
      

      attr_accessor :view
      

      def initialize(attributes = {})
        return if attributes.empty?
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @user_agent = attributes["userAgent"] || attributes[:"user_agent"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @ip = attributes["ip"] || attributes[:"ip"]
        value = attributes["scope"] || attributes[:"scope"]
        if value.is_a?(Array)
          @scope = value.map{ |v| ScopeEntry.new(v) }

        end
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @anonymous = attributes["anonymous"] || attributes[:"anonymous"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @entity_type = attributes["entityType"] || attributes[:"entity_type"]
        value = attributes["ids"] || attributes[:"ids"]
        if value.is_a?(Array)
          @ids = value

        end
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @customer = attributes["customer"] || attributes[:"customer"]
        value = attributes["quantities"] || attributes[:"quantities"]
        if value.is_a?(Array)
          @quantities = value

        end
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @application = attributes["application"] || attributes[:"application"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @view = attributes["view"] || attributes[:"view"]
        

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
          :scope => :scope,
          :anonymous => :anonymous,
          :entity_type => :entityType,
          :ids => :ids,
          :customer => :customer,
          :quantities => :quantities,
          :application => :application,
          :view => :view

        }
    end
  end
end

