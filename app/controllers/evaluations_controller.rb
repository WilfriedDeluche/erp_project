# encoding: utf-8
class EvaluationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :teachers_or_school_users_only, :except => [:index]
  before_filter :find_class
  before_filter :find_student
  before_filter :find_evaluation, :only => [:show, :edit, :update, :destroy]
  respond_to :html, :json
  respond_to :js, :only => [:index]
  
  # GET /evaluations
  # GET /evaluations.json
  def index
    if @student
      unless teacher_signed_in?
        @evaluations = @student.evaluations.order("subject_id ASC")
      else
        @evaluations = @student.evaluations.order("subject_id ASC").select do |e| 
          e if current_user.rolable.subjects.map { |s| s.id }.include?(e.subject_id)
        end
      end
      respond_with @evaluations
    elsif @class
      @students = @class.students
      get_all_subjects
      @selected_subject = (params[:subject_id]) ? params[:subject_id] : @subjects.first
      respond_with @subject
    end
  end

  # GET /evaluations/new
  # GET /evaluations/new.json
  def new
    if @class
      @students = @class.students
      get_all_subjects
    end
    @evaluation = Evaluation.new
    respond_with @evaluation
  end

  # GET /evaluations/1/edit
  def edit
    respond_with @evaluation
  end

  # POST /evaluations
  # POST /evaluations.json
  def create
    @students = params[:evaluation][:student]
    @subject_id = params[:evaluation][:subject_id]
    @scale = params[:evaluation][:scale]
    
    @students.each do |s| 
      unless s.second[:grade].empty?
        Evaluation.create(:student_id => s.first, 
          :subject_id => @subject_id, 
          :scale => @scale, 
          :grade => s.second[:grade])
      end
    end
    
    respond_to do |format|
      format.html { redirect_to class_evaluations_path(@class), notice: "Les notes ont été ajoutées avec succès." }
      format.json { render json: @evaluation, status: :created, location: @evaluation }
    end
  end

  # PUT /evaluations/1
  # PUT /evaluations/1.json
  def update
    respond_to do |format|
      if @evaluation.update_attributes(params[:evaluation])
        format.html { redirect_to student_evaluations_path(@student), notice: "La note a été mise à jour avec succès." }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /evaluations/1
  # DELETE /evaluations/1.json
  def destroy
    @evaluation.destroy

    respond_to do |format|
      format.html { redirect_to student_evaluations_path(@student) }
      format.json { head :ok }
    end
  end
  
  private
  def find_evaluation
    begin
      @evaluation = Evaluation.find(params[:id])
    rescue
      respond_to do |format|
        format.html { redirect_to evaluations_path, alert: "L'évaluation n'existe pas." }
        format.json { render head: :not_found }
      end
    end
  end
  
  def find_class
    return unless params[:class_id]
    begin
      @class = Klass.find(params[:class_id])
    rescue
      respond_to do |format|
        format.html { redirect_to classes_path, alert: "Cette classe n'existe pas." }
        format.json { render head: :not_found }
      end
    end
  end
  
  def find_student
    return unless params[:student_id] || student_signed_in?
    begin
      unless @class
        @student = Student.find(params[:student_id] || current_user.rolable)
      else
        @student = @class.students.find(params[:student_id])
      end
    rescue
      respond_to do |format|
        unless @class
          format.html { redirect_to students_path, alert: "Cette étudiant n'existe pas." }
        else
          format.html { redirect_to class_evaluations_path(@class), alert: "Cette étudiant n'existe pas dans cette classe." }
        end
        format.json { render head: :not_found }
      end
    end
  end
  
  def get_all_subjects
    if teacher_signed_in?
      @subjects = @class.subjects.select { |s| s if current_user.rolable.subjects.include?(s) }
    else
      @subjects = @class.subjects
    end
  end
end
