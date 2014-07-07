module Attune
  module Model
    # 
    #
    # @attr [Array<Blacklist>] blacklists
    class BlacklistGetResponse
      attr_accessor :blacklists
      

      def initialize(attributes = {})
        return if attributes.empty?
        if self.class.attribute_map[:"blacklists"]
          value = attributes["blacklists"] || attributes[:"blacklists"]
            if value.is_a?(Array)
              @blacklists = value.map{ |v| Blacklist.new(v) }

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
          :blacklists => :blacklists

        }
      end
    end
  end
end

