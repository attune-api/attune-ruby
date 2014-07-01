# 
class BlacklistParams
  attr_accessor :active_from
  

  attr_accessor :active_to
  

  attr_accessor :scope
  

  attr_accessor :entity_type
  

  attr_accessor :ids
  

  attr_accessor :disabled
  

  # :internal => :external
  def self.attribute_map
    {
      :active_from => :activeFrom,
      :active_to => :activeTo,
      :scope => :scope,
      :entity_type => :entityType,
      :ids => :ids,
      :disabled => :disabled

    }
  end

  def initialize(attributes = {})
    return if attributes.empty?
    # Morph attribute keys into undescored rubyish style
    if self.class.attribute_map[:"active_from"]
      @active_from = attributes["activeFrom"]
    end
    if self.class.attribute_map[:"active_to"]
      @active_to = attributes["activeTo"]
    end
    if self.class.attribute_map[:"scope"]
      if (value = attributes["scope"]).is_a?(Array)
          @scope = valueend
      end
    if self.class.attribute_map[:"entity_type"]
      @entity_type = attributes["entityType"]
    end
    if self.class.attribute_map[:"ids"]
      if (value = attributes["ids"]).is_a?(Array)
          @ids = valueend
      end
    if self.class.attribute_map[:"disabled"]
      @disabled = attributes["disabled"]
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

