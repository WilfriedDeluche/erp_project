# encoding: utf-8
class Lesson < ActiveRecord::Base
  validate :check_teacher_is_free
  validate :check_classe_is_free
  
  belongs_to :subject
  belongs_to :teacher
  belongs_to :klass
  
  validates_presence_of :subject_id, :teacher_id, :klass_id, :start_date, :end_date
  attr_accessible :subject_id, :teacher_id, :klass_id, :start_date, :end_date, :is_test
  
  def check_teacher_is_free
    teacher_lessons = Lesson.find_all_by_teacher_id(self.teacher_id)
    teacher_lessons.each do |teacher_lesson|
      if self.start_date >= teacher_lesson.start_date && self.start_date <= teacher_lesson.end_date
        self.errors[:base] << "Le professeur #{self.teacher.name} n'est pas disponible sur cette tranche horaire."
      end 
    end
  end
  
  def check_classe_is_free
    classe_lessons = Lesson.find_all_by_klass_id(self.klass_id)
    classe_lessons.each do |classe_lesson|
      if self.start_date >= classe_lesson.start_date && self.start_date <= classe_lesson.end_date
        self.errors[:base] << "La classe #{self.klass.name} a déjà un cours durant cette tranche horaire."
      end 
    end
  end
  
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
