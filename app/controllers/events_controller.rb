# encoding: utf-8
class EventsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :students_only
  before_filter :captain_or_union_member_only, :only => [:new, :create]
  before_filter :set_student_status
  before_filter :find_event, :only => [:show, :edit, :update, :destroy, :attend, :unattend]
  before_filter :owner_only, :only => [:edit, :update, :destroy]
  before_filter :own_class_events_only, :only => [:show, :attend]
  respond_to :html, :json
  
  # GET /events
  # GET /events.json
  def index
    @public_events = Event.where(:klass_id => nil)
    @klass_events = Event.where(:klass_id => current_user.rolable.klasses.order("year DESC").first.id)
    @owner_events = Event.where(:student_id => current_user.rolable.id)
    @events = (@public_events + @klass_events + @owner_events).uniq
    respond_with @events
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    @attendees = @event.attendees.select { |a| a unless a.student.user.nil? }
    @user_attends = (@event.attendees.where(:student_id => current_user.rolable.id).any?) ? true : false
    @user_owns = (@event.student_id == current_user.rolable.id)
    respond_with @event
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new
    respond_with @event
  end

  # GET /events/1/edit
  def edit
    respond_with @event
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event]) do |event|
      event.student_id = current_user.rolable.id
      event.klass_id = current_user.rolable.klasses.order("year DESC").first.id if @student_captain
    end

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: "L'événement a été créé avec succès." }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: "L'événement a été mis à jour avec succès." }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PUT /events/1/attend
  # PUT /events/1/attend.json
  def attend
    @attendee = @event.attendees.build(:student_id => current_user.rolable.id)
    
    respond_to do |format|
      if @attendee.save
        format.html { redirect_to @event, notice: "Votre participation à cet événement a été enregistrée." }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html do
          @attendees = @event.attendees.select { |a| a unless a.student.user.nil? }
          render action: "show"
        end
        format.json { render json: @attendee.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PUT /events/1/unattend
  # PUT /events/1/unattend.json
  def unattend
    @attendee = @event.attendees.where(:student_id => current_user.rolable.id).first
    
    if @attendee
      @attendee.destroy
      respond_to do |format|
        format.html { redirect_to @event, notice: "Votre participation à cet événement a été supprimée." }
        format.json { render json: @event, status: :created, location: @event }
      end
    else
      respond_to do |format|
        format.html { redirect_to @event, notice: "Vous ne participez pas à cet événement." }
        format.json { render json: @event, status: :created, location: @event }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :ok }
    end
  end
  
  private
  def find_event
    begin
      @event = Event.find(params[:id])
    rescue
      respond_to do |format|
        format.html { redirect_to events_path, alert: "L'événement n'existe pas." }
        format.json { render head: :not_found }
      end
    end
  end
  
  def own_class_events_only
    return if @event.klass_id.nil? || @event.student_id == current_user.rolable.id
    unless @event.klass_id == current_user.rolable.klasses.order("year DESC").first.id
      respond_to do |format|
        format.html { redirect_to events_path, alert: "Vous n'avez pas les droits pour visualiser ou participer à cet événement." }
        format.json { render head: :not_found }
      end
    end
  end
  
  def set_student_status
    @student_captain = current_user.rolable.is_captain
    @student_union_member = current_user.rolable.is_student_union_member
    @student_admin = @student_captain || @student_union_member
  end
end
