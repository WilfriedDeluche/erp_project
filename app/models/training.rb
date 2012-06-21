class Training < ActiveRecord::Base
  
  has_many :klasses
  
  validates_presence_of :name, :section, :level
  attr_accessible :name, :section, :level
  
  def short_name
    "#{section.upcase} #{level}"    
  end
end
