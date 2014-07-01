# 
class RankingParams
  attr_accessor :ip
  

  attr_accessor :view
  

  attr_accessor :customer
  

  attr_accessor :scope
  

  attr_accessor :user_agent
  

  attr_accessor :entity_type
  

  attr_accessor :ids
  

  attr_accessor :anonymous
  

  # :internal => :external
  def self.attribute_map
    {
      :ip => :ip,
      :view => :view,
      :customer => :customer,
      :scope => :scope,
      :user_agent => :userAgent,
      :entity_type => :entityType,
      :ids => :ids,
      :anonymous => :anonymous

    }
  end

  def initialize(attributes = {})
    return if attributes.empty?
    # Morph attribute keys into undescored rubyish style
    if self.class.attribute_map[:"ip"]
      @ip = attributes["ip"]
    end
    if self.class.attribute_map[:"view"]
      @view = attributes["view"]
    end
    if self.class.attribute_map[:"customer"]
      @customer = attributes["customer"]
    end
    if self.class.attribute_map[:"scope"]
      if (value = attributes["scope"]).is_a?(Array)
          @scope = value.map{ |v| ScopeEntry.new(v) }end
      end
    if self.class.attribute_map[:"user_agent"]
      @user_agent = attributes["userAgent"]
    end
    if self.class.attribute_map[:"entity_type"]
      @entity_type = attributes["entityType"]
    end
    if self.class.attribute_map[:"ids"]
      if (value = attributes["ids"]).is_a?(Array)
          @ids = valueend
      end
    if self.class.attribute_map[:"anonymous"]
      @anonymous = attributes["anonymous"]
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

