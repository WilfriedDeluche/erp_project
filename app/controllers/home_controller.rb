class HomeController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    if student_signed_in?
      @events = Event.where("start_date > ?", DateTime.now).select { |e| e if e.attendees.where(:student_id => current_user.rolable.id).any? }
    end
  end
end
