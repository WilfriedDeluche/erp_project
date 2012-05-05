class Student < ActiveRecord::Base
  
  has_one :user, :as => :rolable
  
  attr_accessible :birthdate, :address, :zip_code, :city, :home_phone_number, :mobile_phone_number
end
