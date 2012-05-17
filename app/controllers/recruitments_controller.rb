class RecruitmentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :school_users_only
  before_filter :find_student
  respond_to :html, :json
  
  
  # GET /students/1/recruitments
  def index
    @recruitments = @student.recruitments.order("start_date DESC")
    respond_with @recruitments
  end
  
  # GET /students/1/recruitments/new
  def new
    @recruiters = Recruiter.all
    @current_recruiter = @student.recruitments.order("start_date DESC").first
    @recruitment = Recruitment.new
  end
  
  # POST /students/1/recruitments
  def create
    @current_recruiter = @student.recruitments.order("start_date DESC").first
    
    @recruitment = @student.recruitments.build(params[:recruitment]) do |rec|
      rec.start_date = DateTime.now
    end
    
    respond_to do |format|
      if @current_recruiter && @recruitment.recruiter.id == @current_recruiter.recruiter.id
        format.html { redirect_to new_recruiter_student_path(@student), alert: "Vous avez choisi le charge de placement actuel. Aucun changement n'a ete opere." }
        format.json { render head: :ok }
      elsif @recruitment.valid?
        if @current_recruiter && @current_recruiter.end_date.nil?
          @current_recruiter.end_date = DateTime.now
          @current_recruiter.save
        end
        @recruitment.save
      
        format.html { redirect_to student_path(@student), notice: "Student's recruiter has been changed" }
        format.json { render head: :ok }
      else
        @recruiters = Recruiter.all
        
        format.html { render action: "new_recruiter" }
        format.json { render json: @new_recruiter.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def find_student
    begin
      @student = Student.find(params[:student_id])
      raise RecordNotFound.new if @student.user.nil?
    rescue
      respond_to do |format|
        format.html { redirect_to students_path, alert: 'Student does not exist.' }
        format.json { render head: :not_found }
      end
    end
  end
end
