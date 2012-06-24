class Student < ActiveRecord::Base
  
  has_one :user, :as => :rolable
  has_many :recruitments
  has_many :recruiters, :through => :recruitments
  has_many :contracts
  has_many :companies, :through => :contracts
  has_many :events
  
  has_and_belongs_to_many :klasses
  
  attr_accessible :birthdate, :address, :zip_code, :city, :home_phone_number, :mobile_phone_number,
          :is_captain, :is_student_union_member
end
