module Attune
  module Model
    # 
    #
    # @attr [String] id 
    # @attr [String] result 
    class BlacklistSaveResponse
      attr_accessor :id
      

      attr_accessor :result
      

      def initialize(attributes = {})
        return if attributes.empty?
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @id = attributes["id"] || attributes[:"id"]
        # Workaround since JSON.parse has accessors as strings rather than symbols
        @result = attributes["result"] || attributes[:"result"]
        

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
          :result => :result

        }
    end
  end
end

