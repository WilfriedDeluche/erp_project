class Teacher < ActiveRecord::Base
  
  has_one :user, :as => :rolable
  has_and_belongs_to_many :subjects
  
  has_many :lessons  
  
  attr_accessible :arrival_year
end
