class Evaluation < ActiveRecord::Base
  
  belongs_to :student
  belongs_to :subject
  
  validates_presence_of :grade, :scale, :student_id, :subject_id
  attr_accessible :grade, :scale, :student_id, :subject_id
  
end
