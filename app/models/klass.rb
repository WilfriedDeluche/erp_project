# encoding: utf-8
class Klass < ActiveRecord::Base
    
  belongs_to :training
  has_and_belongs_to_many :students
  has_and_belongs_to_many :subjects
  has_many :events
  
  validates_presence_of :training_id, :year
  validates_uniqueness_of :year, :scope => :training_id
  validates_format_of :year, :with => /\A20[0-9]{2}\Z/
  
  attr_accessible :training_id, :year
  
  def name
    "#{self.training.section.upcase} #{self.training.level} - #{self.year}"
  end
end
