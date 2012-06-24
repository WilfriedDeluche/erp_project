class Attendee < ActiveRecord::Base
  
  belongs_to :event
  belongs_to :student
  
  validates_presence_of :event_id, :student_id
end
