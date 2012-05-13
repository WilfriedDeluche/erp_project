class StudentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :school_users_only, :except => [:show, :index]
  before_filter :find_student, :only => [:show, :edit, :update, :destroy, :reinvite_user, :recruiters_list, :new_recruiter]
  respond_to :html, :json
  
  # GET /students
  # GET /students.json
  def index
    @students = Student.all.select { |s| s unless s.user.nil? }
    respond_with @students
  end

  # GET /students/1
  # GET /students/1.json
  def show
    @current_recruiter = @student.recruiter_students.order("start_date DESC").first
    @recruiters_count = @student.recruiter_students.count
    respond_with @student
  end

  # GET /students/new
  # GET /students/new.json
  def new
    @student = Student.new
    @user = User.new
    respond_with @student
  end

  # GET /students/1/edit
  def edit
    @user = @student.user
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(params[:student])
    @user = User.new(params[:user]) do |u|
      u.rolable = @student
      u.skip_password_validation = true
    end
    
    valid = @user.valid? 
    valid = @student.valid? && valid
    
    if valid
      create_and_send_invitation(@user, @student, "Student")
    else
      respond_to do |format|
        format.html { render action: "new" }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /students/1
  # PUT /students/1.json
  def update
    @user = @student.user
    respond_to do |format|
      if @student.update_attributes(params[:student]) && @user.update_attributes(params[:user])
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.user.destroy
    @student.destroy

    respond_to do |format|
      format.html { redirect_to students_url }
      format.json { head :ok }
    end
  end
  
  # PUT /students/1/reinvite_user
  def reinvite_user
    resend_invitation(@student.user, "Student")
  end
  
  # GET /students/1/recruiters_list
  def recruiters_list
    @recruiters_list = @student.recruiter_students.order("start_date DESC")
    respond_with @recruiters_list
  end
  
  # GET /students/1/new_recruiter
  def new_recruiter
    @recruiters = Recruiter.all
    @current_recruiter = @student.recruiter_students.order("start_date DESC").first
    @recruiter = RecruiterStudent.new
  end
  
  # POST /students/1/
  def create_recruiter
    
  end
  
  private
  def find_student
    begin
      @student = Student.find(params[:id])
      raise RecordNotFound.new if @student.user.nil?
    rescue
      respond_to do |format|
        format.html { redirect_to students_path, alert: 'Student does not exist.' }
        format.json { render head: :not_found }
      end
    end
  end
end
