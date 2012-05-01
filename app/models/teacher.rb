class Teacher < ActiveRecord::Base
  
  has_one :user, :as => :rolable
  
  attr_accessible :arrival_year
end
