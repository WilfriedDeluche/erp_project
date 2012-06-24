class PublicPagesController < ApplicationController
  def school
  end
  
  def news
    @events = Event.where(:klass_id => nil && :start_date > DateTime.now)
  end
  
  def contact
  end
end
