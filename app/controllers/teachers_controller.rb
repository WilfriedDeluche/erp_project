class TeachersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :school_users_only
  before_filter :find_teacher, :only => [:show, :edit, :update, :destroy]
  respond_to :html, :json
  
  # GET /teachers
  # GET /teachers.json
  def index
    @teachers = Teacher.all
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
    end
    
    valid = @user.valid? 
    valid = @teacher.valid? && valid
    
    respond_to do |format|
      if valid
        @teacher.save
        @user.save
        format.html { redirect_to @teacher, notice: 'Teacher was successfully created.' }
        format.json { render json: @teacher, status: :created, location: @teacher }
      else
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
  
  private
  def find_teacher
    begin
      @teacher = Teacher.find(params[:id])
    rescue
      respond_to do |format|
        format.html { redirect_to teachers_path, alert: 'Teacher does not exist.' }
        format.json { render head: :not_found }
      end
    end
  end
end
