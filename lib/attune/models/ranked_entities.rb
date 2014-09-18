module Attune
  module Model
    # List of ids in ranked order. If an error occurs, returns message and status code.
    #
    # @attr [String] message Error message if ranking failed
    # @attr [Integer] status HTTP status code if ranking failed
    # @attr [String] cell Cell assignment
    # @attr [Array<String>] ranking List of ids in ranked order
    class RankedEntities
      attr_accessor :message
      

      attr_accessor :status
      

      attr_accessor :cell
      

      attr_accessor :ranking
      

      def initialize(attributes = {})
        return if attributes.empty?
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @message = attributes["message"] || attributes[:"message"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @status = attributes["status"] || attributes[:"status"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @cell = attributes["cell"] || attributes[:"cell"]
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
          :cell => :cell,
          :ranking => :ranking

        }
    end
  end
end

