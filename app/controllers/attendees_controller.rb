# encoding: utf-8
class AttendeesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :students_only
  before_filter :find_event
  before_filter :owner_only, :only => [:destroy]
  respond_to :html, :json
  

  # DELETE /attendees/1
  # DELETE /attendees/1.json
  def destroy
    @attendee = @event.attendees.find(params[:id])
    @attendee.destroy

    respond_to do |format|
      format.html { redirect_to event_path(@event), :alert => "Participant supprimé" }
      format.json { head :ok }
    end
  end
  
  private
  def find_event
    begin
      @event = Event.find(params[:event_id])
    rescue
      respond_to do |format|
        format.html { redirect_to events_path, alert: "L'événement n'existe pas." }
        format.json { render head: :not_found }
      end
    end
  end
end
