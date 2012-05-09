class RecruitersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin_only, :only => [:edit, :update, :destroy, :create, :new]
  before_filter :find_recruiter, :only => [:show, :edit, :update, :destroy, :reinvite_user]
  respond_to :html, :json
  
  # GET /recruiters
  # GET /recruiters.json
  def index
    @recruiters = Recruiter.all.select { |r| r unless r.user.nil? }
    respond_with @recruiters
  end

  # GET /recruiters/1
  # GET /recruiters/1.json
  def show
    respond_with @recruiter
  end

  # GET /recruiters/new
  # GET /recruiters/new.json
  def new
    @recruiter = Recruiter.new
    @user = User.new
    respond_with @recruiter
  end

  # GET /recruiters/1/edit
  def edit
    @user = @recruiter.user
  end

  # POST /recruiters
  # POST /recruiters.json
  def create
    @recruiter = Recruiter.new(params[:recruiter])
    @user = User.new(params[:user]) do |u|
      u.rolable = @recruiter
    end
    
    valid = @user.valid? 
    valid = @recruiter.valid? && valid
    
    respond_to do |format|
      if valid
        @recruiter.save
        @user.save
        format.html { redirect_to @recruiter, notice: 'Recruiter was successfully created.' }
        format.json { render json: @recruiter, status: :created, location: @recruiter }
      else
        format.html { render action: "new" }
        format.json { render json: @recruiter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /recruiters/1
  # PUT /recruiters/1.json
  def update
    @user = @recruiter.user
    respond_to do |format|
      if @recruiter.update_attributes(params[:recruiter]) && @user.update_attributes(params[:user])
        format.html { redirect_to @recruiter, notice: 'Recruiter was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @recruiter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recruiters/1
  # DELETE /recruiters/1.json
  def destroy
    @recruiter.user.destroy
    @recruiter.destroy

    respond_to do |format|
      format.html { redirect_to recruiters_url }
      format.json { head :ok }
    end
  end
  
  private
  def find_recruiter
    begin
      @recruiter = Recruiter.find(params[:id])
      raise RecordNotFound.new if @recruiter.user.nil?
    rescue
      respond_to do |format|
        format.html { redirect_to recruiters_path, alert: 'Recruiter does not exist.' }
        format.json { render head: :not_found }
      end
    end
  end
end
