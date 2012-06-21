class Klass < ActiveRecord::Base
    
  belongs_to :training
  
  validates_presence_of :training_id, :year
  validates_uniqueness_of :year, :scope => :training_id
  validates_format_of :year, :with => /\A20[0-9]{2}\Z/
  
  attr_accessible :training_id, :year
end
