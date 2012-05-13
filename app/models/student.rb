class Student < ActiveRecord::Base
  
  has_one :user, :as => :rolable
  has_many :recruiter_students
  has_many :recruiters, :through => :recruiter_students
  
  attr_accessible :birthdate, :address, :zip_code, :city, :home_phone_number, :mobile_phone_number
end
