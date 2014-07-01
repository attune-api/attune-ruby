# 
class Blacklist
  attr_accessor :id
  

  attr_accessor :scope
  

  attr_accessor :ids
  

  attr_accessor :disabled
  

  attr_accessor :consumer
  

  attr_accessor :entity_type
  

  attr_accessor :start_date
  

  attr_accessor :end_date
  

  attr_accessor :created_at
  

  # :internal => :external
  def self.attribute_map
    {
      :id => :id,
      :scope => :scope,
      :ids => :ids,
      :disabled => :disabled,
      :consumer => :consumer,
      :entity_type => :entityType,
      :start_date => :startDate,
      :end_date => :endDate,
      :created_at => :createdAt

    }
  end

  def initialize(attributes = {})
    return if attributes.empty?
    # Morph attribute keys into undescored rubyish style
    if self.class.attribute_map[:"id"]
      @id = attributes["id"]
    end
    if self.class.attribute_map[:"scope"]
      if (value = attributes["scope"]).is_a?(Array)
          @scope = valueend
      end
    if self.class.attribute_map[:"ids"]
      if (value = attributes["ids"]).is_a?(Array)
          @ids = valueend
      end
    if self.class.attribute_map[:"disabled"]
      @disabled = attributes["disabled"]
    end
    if self.class.attribute_map[:"consumer"]
      @consumer = attributes["consumer"]
    end
    if self.class.attribute_map[:"entity_type"]
      @entity_type = attributes["entityType"]
    end
    if self.class.attribute_map[:"start_date"]
      @start_date = attributes["startDate"]
    end
    if self.class.attribute_map[:"end_date"]
      @end_date = attributes["endDate"]
    end
    if self.class.attribute_map[:"created_at"]
      @created_at = attributes["createdAt"]
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

