class Lesson < ActiveRecord::Base
  belongs_to :subject
  belongs_to :teacher
  belongs_to :klass
  
  validates_presence_of :subject_id, :teacher_id, :klass_id, :start_date, :end_date
  attr_accessible :subject_id, :teacher_id, :klass_id, :start_date, :end_date, :is_test
end
