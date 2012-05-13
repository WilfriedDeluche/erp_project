class RecruiterStudent < ActiveRecord::Base
  belongs_to :student
  belongs_to :recruiter
  
  validates_presence_of :student_id, :recruiter_id, :start_date
end
