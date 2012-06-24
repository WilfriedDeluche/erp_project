# encoding: utf-8
class SubjectsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :school_users_only, :except => [:show, :index, :edit, :update]
  before_filter :teachers_or_school_users_only, :only => [:edit, :update]
  before_filter :find_subject, :only => [:show, :edit, :update, :destroy]
  respond_to :html, :json
  
  # GET /subjects
  # GET /subjects.json
  def index
    if teacher_signed_in?
      @subjects = current_user.rolable.subjects # teachers can only see the subjects they're assigned to
    elsif student_signed_in?
      @subjects = @current_class.subjects # students can only see the subjects their current class is registered to
    else
      @subjects = Subject.all
    end
    respond_with @subjects
  end

  # GET /subjects/1
  # GET /subjects/1.json
  def show
    @teachers = @subject.teachers
    @classes = @subject.klasses
    respond_with @subject
  end

  # GET /subjects/new
  # GET /subjects/new.json
  def new
    @subject = Subject.new
    get_all_teachers
    get_all_classes
    respond_with @subject
  end

  # GET /subjects/1/edit
  def edit
    get_all_teachers
    get_all_classes
    respond_with @subject
  end

  # POST /subjects
  # POST /subjects.json
  def create
    @subject = Subject.new(params[:subject])

    respond_to do |format|
      if @subject.save
        format.html { redirect_to @subject, notice: 'La matière a bien été créée.' }
        format.json { render json: @subject, status: :created, location: @subject }
      else
        format.html do
          get_all_teachers
          get_all_classes
          render action: "new"
        end
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /subjects/1
  # PUT /subjects/1.json
  def update
    params[:subject][:teachers_list] ||= {}
    params[:subject][:classes_list] ||= {}
    respond_to do |format|
      if @subject.update_attributes(params[:subject])
        format.html { redirect_to @subject, notice: 'La matière a bien été mise à jour.' }
        format.json { head :ok }
      else
        format.html do
          get_all_teachers
          get_all_classes
          render action: "edit"
        end
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subjects/1
  # DELETE /subjects/1.json
  def destroy
    @subject.destroy

    respond_to do |format|
      format.html { redirect_to subjects_url }
      format.json { head :ok }
    end
  end
  
  private
  def find_subject
    begin
      @subject = Subject.find(params[:id])
    rescue
      respond_to do |format|
        format.html { redirect_to subjects_path, alert: "La matière n'existe pas." }
        format.json { render head: :not_found }
      end
    end
  end
  
  def get_all_teachers
    @teachers = Teacher.all
  end
  
  def get_all_classes
    @classes = Klass.all
  end
end
