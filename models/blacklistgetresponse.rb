# 
class BlacklistGetResponse
  attr_accessor :blacklists
  

  # :internal => :external
  def self.attribute_map
    {
      :blacklists => :blacklists

    }
  end

  def initialize(attributes = {})
    return if attributes.empty?
    # Morph attribute keys into undescored rubyish style
    if self.class.attribute_map[:"blacklists"]
      if (value = attributes["blacklists"]).is_a?(Array)
          @blacklists = value.map{ |v| Blacklist.new(v) }end
      end
    

  end

  def to_body
    body = {}
    self.class.attribute_map.each_pair do |key, value|
      body[value] = self.send(key) unless self.send(key).nil?
    end
    body
  end
end

