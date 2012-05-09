class TeachersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :school_users_only
  before_filter :find_teacher, :only => [:show, :edit, :update, :destroy, :reinvite_user]
  respond_to :html, :json
  
  # GET /teachers
  # GET /teachers.json
  def index
    @teachers = Teacher.all.select { |t| t unless t.user.nil? }
    respond_with @teachers
  end

  # GET /teachers/1
  # GET /teachers/1.json
  def show
    respond_with @teacher
  end

  # GET /teachers/new
  # GET /teachers/new.json
  def new
    @teacher = Teacher.new
    @user = User.new
    respond_with @teacher
  end

  # GET /teachers/1/edit
  def edit
    @user = @teacher.user
  end

  # POST /teachers
  # POST /teachers.json
  def create
    @teacher = Teacher.new(params[:teacher])
    @user = User.new(params[:user]) do |u|
      u.rolable = @teacher
      u.skip_password_validation = true
      u.is_admin = params[:user][:is_admin] if current_user.is_admin # is_admin is non accessible
    end
    
    valid = @user.valid? 
    valid = @teacher.valid? && valid
        
    if valid
      create_and_send_invitation(@user, @teacher, "Teacher")
    else
      respond_to do |format|
        format.html { render action: "new" }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /teachers/1
  # PUT /teachers/1.json
  def update
    @user = @teacher.user
    respond_to do |format|
      if @teacher.update_attributes(params[:teacher]) && @user.update_attributes(params[:user])
        @user.update_attribute(:is_admin, params[:user][:is_admin]) if current_user.is_admin # is_admin is non accessible
        format.html { redirect_to @teacher, notice: 'Teacher was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teachers/1
  # DELETE /teachers/1.json
  def destroy
    @teacher.user.destroy
    @teacher.destroy

    respond_to do |format|
      format.html { redirect_to teachers_url }
      format.json { head :ok }
    end
  end
  
  # PUT /school_users/1/reinvite_user
  def reinvite_user
    resend_invitation(@teacher.user, "Teacher")
  end
  
  private
  def find_teacher
    begin
      @teacher = Teacher.find(params[:id])
      raise RecordNotFound.new if @teacher.user.nil?
    rescue
      respond_to do |format|
        format.html { redirect_to teachers_path, alert: 'Teacher does not exist.' }
        format.json { render head: :not_found }
      end
    end
  end
end
