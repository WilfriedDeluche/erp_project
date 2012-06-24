class Lesson < ActiveRecord::Base
  belongs_to :subject
  belongs_to :teacher
  belongs_to :klass
  
  validates_presence_of :subject_id, :teacher_id, :klass_id, :start_date, :end_date
  attr_accessible :subject_id, :teacher_id, :klass_id, :start_date, :end_date, :is_test
  
  def klass_and_lesson
    "#{self.klass.name_and_level} : #{self.subject.name}"
  end
  
  def start_time
    return self.start_date.strftime("%Hh%M")
  end
  
  def end_time
    return self.end_date.strftime("%Hh%M")
  end
end
