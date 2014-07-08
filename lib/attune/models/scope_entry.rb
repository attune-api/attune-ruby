module Attune
  module Model
    # Name value pairs indicating the context where a ranking will be displayed.
    #
    # @attr [String] name
    # @attr [String] value
    class ScopeEntry
      attr_accessor :name
      

      attr_accessor :value
      

      def initialize(attributes = {})
        return if attributes.empty?
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @name = attributes["name"] || attributes[:"name"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @value = attributes["value"] || attributes[:"value"]
        

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
          :name => :name,
          :value => :value

        }
    end
  end
end

