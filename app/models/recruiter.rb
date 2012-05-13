class Recruiter < ActiveRecord::Base
  
  has_one :user, :as => :rolable
  has_many :recruiter_students
  has_many :students, :through => :recruiter_students
  
  attr_accessible :arrival_date
  
  def name
    "#{self.user.first_name} #{self.user.last_name}"
  end
end
