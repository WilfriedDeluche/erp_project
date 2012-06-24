# encoding: utf-8
class KlassesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :school_users_only, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :find_class, :only => [:show, :edit, :update, :destroy]
  respond_to :html, :json
  
  # GET /classes
  # GET /classes.json
  def index
    if teacher_signed_in?
      @subjects = current_user.rolable.subjects
      @classes = @subjects.map { |s| s.klasses }.flatten.uniq
    else
      @classes = Klass.order("year DESC")
    end
    respond_with @classes
  end

  # GET /classes/1
  # GET /classes/1.json
  def show
    @students = @class.students.order("created_at ASC")
    respond_with @class
  end

  # GET /classes/new
  # GET /classes/new.json
  def new
    @class = Klass.new
    @trainings = Training.all
    respond_with @class
  end

  # GET /classes/1/edit
  def edit
    @trainings = Training.all
    respond_with @class
  end

  # POST /classes
  # POST /classes.json
  def create
    @class = Klass.new(params[:klass])

    respond_to do |format|
      if @class.save
        format.html { redirect_to class_path(@class), notice: 'La classe a bien été créée.' }
        format.json { render json: @class, status: :created, location: @class }
      else
        format.html do
          @trainings = Training.all
          render action: "new"
        end
        format.json { render json: @class.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /classes/1
  # PUT /classes/1.json
  def update
    respond_to do |format|
      if @class.update_attributes(params[:klass])
        format.html { redirect_to class_path(@class), notice: 'La classe a bien été mise à jour.' }
        format.json { head :ok }
      else
        format.html do
          @trainings = Training.all
          render action: "edit"
        end
        format.json { render json: @class.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /classes/1
  # DELETE /classes/1.json
  def destroy
    @class.destroy

    respond_to do |format|
      format.html { redirect_to classes_path }
      format.json { head :ok }
    end
  end
  
  private
  def find_class
    begin
      @class = Klass.find(params[:id])
      if teacher_signed_in?
        raise RecordNotFound.new unless current_user.rolable.subjects.map { |s| s.klasses }.flatten.uniq.include?(@class)
      end
    rescue
      respond_to do |format|
        format.html { redirect_to classes_path, alert: "Cette classe n'existe pas ou n'est pas gérée par vous." }
        format.json { render head: :not_found }
      end
    end
  end
end
