module Attune
  module Model
    # List of ids in ranked order. If an error occurs, returns message and status code.
    #
    # @attr [String] message
    # @attr [Integer] status
    # @attr [Array<String>] ranking
    class RankedEntities
      attr_accessor :message
      

      attr_accessor :status
      

      attr_accessor :ranking
      

      def initialize(attributes = {})
        return if attributes.empty?
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @message = attributes["message"] || attributes[:"message"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @status = attributes["status"] || attributes[:"status"]
        value = attributes["ranking"] || attributes[:"ranking"]
        if value.is_a?(Array)
          @ranking = value

        end
        

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
          :message => :message,
          :status => :status,
          :ranking => :ranking

        }
    end
  end
end

