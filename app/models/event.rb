# encoding: utf-8
class Event < ActiveRecord::Base
  
  belongs_to :student
  belongs_to :klass
  
  has_many :attendees
  
  validates_presence_of :name, :start_date, :end_date, :location, :student_id
  validate :start_date_before_end_date
  
  attr_accessible :name, :start_date, :end_date, :location, :klass_id, :description
  
  def start_date_before_end_date
    errors.add :start_date, "doit être avant la date de fin" if end_date < start_date
  end
end
