module Attune
  module Model
    # List of ids in ranked order. If an error occurs, returns message and status code.
    #
    # @attr [String] message
    # @attr [Integer] status
    # @attr [Array<string>] ranking
    class RankedEntities
      attr_accessor :message
      

      attr_accessor :status
      

      attr_accessor :ranking
      

      def initialize(attributes = {})
        return if attributes.empty?
        if self.class.attribute_map[:"message"]
          # Workaround since JSON.parse has accessors as strings rather than symbols
            @message = attributes["message"] || attributes[:"message"]
        end
        if self.class.attribute_map[:"status"]
          # Workaround since JSON.parse has accessors as strings rather than symbols
            @status = attributes["status"] || attributes[:"status"]
        end
        if self.class.attribute_map[:"ranking"]
          value = attributes["ranking"] || attributes[:"ranking"]
            if value.is_a?(Array)
              @ranking = value.map{ |v| String.new(v) }

            end
          end
        

      end

      def to_body
        body = {}
        self.class.attribute_map.each_pair do |key, value|
          body[value] = self.send(key) unless self.send(key).nil?
        end
        body
      end

      def to_json(options = {})
        to_body.to_json
      end

      private
      # :internal => :external
      def self.attribute_map
        {
          :message => :message,
          :status => :status,
          :ranking => :ranking

        }
      end
    end
  end
end

