class Recruiter < ActiveRecord::Base
  
  has_one :user, :as => :rolable
  has_many :recruitments
  has_many :students, :through => :recruitments
  has_many :contracts
  
  attr_accessible :arrival_date
  
  def name
    "#{self.user.first_name} #{self.user.last_name}"
  end
end
