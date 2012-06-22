class Subject < ActiveRecord::Base
  
  has_and_belongs_to_many :teachers
  has_and_belongs_to_many :klasses
  
  validates_presence_of :name, :description
  attr_accessible :name, :description, :teachers_list, :classes_list
  
  attr_accessor :teachers_list, :classes_list
  after_save :update_teachers, :update_classes

  private 

  def update_teachers
    return if teachers_list.nil?
    teachers.delete_all
    teachers_list.keys.uniq.collect{ |id| Teacher.find_by_id(id) }.each { |t| self.teachers << t }
  end
  
  def update_classes
    return if classes_list.nil?
    klasses.delete_all
    classes_list.keys.uniq.collect{ |id| Klass.find_by_id(id) }.each { |k| self.klasses << k }
  end
end
