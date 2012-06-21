class Training < ActiveRecord::Base
  
  validates_presence_of :name, :section, :level
  attr_accessible :name, :section, :level
end
