class SchoolUser < ActiveRecord::Base
  
  has_one :user, :as => :rolable
  validates_presence_of :position
  
  attr_accessible :position
end
