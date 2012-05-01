class SchoolUser < ActiveRecord::Base
  
  has_one :user, :as => :rolable
end
