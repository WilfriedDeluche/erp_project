class StudentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :school_users_only, :except => [:show, :index]
  before_filter :find_student, :only => [:show, :edit, :update, :destroy, :reinvite_user]
  before_filter :own_recruiter_only, :only => [:show]
  respond_to :html, :json
  
  # GET /students
  # GET /students.json
  def index
    unless current_user.is_recruiter?
      @students = Student.all.select { |s| s unless s.user.nil? }
    else
      @students = current_user.rolable.recruitments.where(:end_date => nil).map { |recruitment| recruitment.student }
    end
    respond_with @students
  end

  # GET /students/1
  # GET /students/1.json
  def show
    @current_recruiter = @student.recruitments.order("start_date DESC").first
    @recruiters_count = @student.recruitments.count
    @current_contract = @student.contracts.where("start_date < '#{Date.today}' AND end_date > '#{Date.today}'").first
    @contracts_count = @student.contracts.count
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
  
  def own_recruiter_only
    return unless current_user.is_recruiter?
    unless current_user.rolable.recruitments.where(:student_id => @student.id, :end_date => nil).any?
      respond_to do |format|
        format.html { redirect_to students_path, alert: 'You are not in charge of this student.' }
        format.json { render head: :not_found }
      end 
    end
  end
end
