class Subject < ActiveRecord::Base
  
  has_and_belongs_to_many :teachers
  
  validates_presence_of :name, :description
  attr_accessible :name, :description
  
  attr_accessor :teachers_list
  after_save :update_teachers

  private 

  def update_teachers
    debugger
    return if teachers_list.nil?
    teachers.delete_all
    teachers_list.keys.collect{ |id| Teacher.find_by_id(id) }.each { |t| self.teachers << t }
  end
end
