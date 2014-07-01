# 
class ScopeEntry
  attr_accessor :name
  

  attr_accessor :value
  

  # :internal => :external
  def self.attribute_map
    {
      :name => :name,
      :value => :value

    }
  end

  def initialize(attributes = {})
    return if attributes.empty?
    # Morph attribute keys into undescored rubyish style
    if self.class.attribute_map[:"name"]
      @name = attributes["name"]
    end
    if self.class.attribute_map[:"value"]
      @value = attributes["value"]
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

