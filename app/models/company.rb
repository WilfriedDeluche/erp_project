class Company < ActiveRecord::Base
  
  validates_presence_of :corporate_name
  validates_format_of :contact_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :allow_nil => true, :allow_blank => true
end
