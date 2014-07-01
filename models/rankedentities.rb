# 
class RankedEntities
  attr_accessor :message
  

  attr_accessor :ranking
  

  attr_accessor :status
  

  # :internal => :external
  def self.attribute_map
    {
      :message => :message,
      :ranking => :ranking,
      :status => :status

    }
  end

  def initialize(attributes = {})
    return if attributes.empty?
    # Morph attribute keys into undescored rubyish style
    if self.class.attribute_map[:"message"]
      @message = attributes["message"]
    end
    if self.class.attribute_map[:"ranking"]
      if (value = attributes["ranking"]).is_a?(Array)
          @ranking = valueend
      end
    if self.class.attribute_map[:"status"]
      @status = attributes["status"]
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

