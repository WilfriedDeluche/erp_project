class SchoolUsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :school_users_only
  before_filter :admin_only, :only => [:edit, :update, :destroy, :create, :new]
  before_filter :find_school_user, :only => [:show, :edit, :update, :destroy]
  respond_to :html, :json
  
  # GET /school_users
  # GET /school_users.json
  def index
    @school_users = SchoolUser.all.select { |su| su unless su.user.nil? }
    respond_with @school_users
  end

  # GET /school_users/1
  # GET /school_users/1.json
  def show
    respond_with @school_user
  end

  # GET /school_users/new
  # GET /school_users/new.json
  def new
    @school_user = SchoolUser.new
    @user = User.new
    respond_with @school_user
  end

  # GET /school_users/1/edit
  def edit
    @user = @school_user.user
  end

  # POST /school_users
  # POST /school_users.json
  def create
    @school_user = SchoolUser.new(params[:school_user])
    @user = User.new(params[:user]) do |u|
      u.rolable = @school_user
      u.skip_password_validation = true
    end
    
    valid = @user.valid? 
    valid = @school_user.valid? && valid
    
    respond_to do |format|
      if valid
        @school_user.save
        @user.invite! do |u|
          u.invited_by_id = current_user.id
        end        
        format.html { redirect_to @school_user, notice: 'School user was successfully created.' }
        format.json { render json: @school_user, status: :created, location: @school_user }
      else
        format.html { render action: "new" }
        format.json { render json: @school_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /school_users/1
  # PUT /school_users/1.json
  def update
    @user = @school_user.user
    respond_to do |format|
      if @school_user.update_attributes(params[:school_user]) && @user.update_attributes(params[:user])
        format.html { redirect_to @school_user, notice: 'School user was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @school_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /school_users/1
  # DELETE /school_users/1.json
  def destroy
    @school_user.user.destroy    
    @school_user.destroy

    respond_to do |format|
      format.html { redirect_to school_users_url }
      format.json { head :ok }
    end
  end

  private
  def find_school_user
    begin
      @school_user = SchoolUser.find(params[:id])
      raise RecordNotFound.new if @school_user.user.nil?
    rescue
      respond_to do |format|
        format.html { redirect_to school_users_path, alert: 'School user does not exist.' }
        format.json { render head: :not_found }
      end
    end
  end
end
