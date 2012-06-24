class Attendee < ActiveRecord::Base
  
  belongs_to :event
  belongs_to :student
  
  validates_presence_of :event_id, :student_id
  validate :can_only_attend_once
  
  def can_only_attend_once
    errors.add :student_id, "ne peut participer qu'une seule fois" if self.event.attendees.where(:student_id => self.student_id).any?
  end
end
