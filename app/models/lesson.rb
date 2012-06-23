class Lesson < ActiveRecord::Base
  belongs_to :subject
  belongs_to :teacher
  belongs_to :klass
  
  validates_presence_of :date_and_time, :subject_id, :teacher_id, :klass_id
  attr_accessible :date_and_time, :subject_id, :teacher_id, :klass_id
end
