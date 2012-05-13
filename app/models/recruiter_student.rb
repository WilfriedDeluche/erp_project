class RecruiterStudent < ActiveRecord::Base
  belongs_to :student
  belongs_to :recruiter
end
