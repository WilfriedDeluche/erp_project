class Recruiter < ActiveRecord::Base
  
  has_one :user, :as => :rolable
  
  attr_accessible :arrival_date
end
