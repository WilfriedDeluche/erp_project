class Subject < ActiveRecord::Base
  
  validates_presence_of :name, :description
  attr_accessible :name, :description
end
