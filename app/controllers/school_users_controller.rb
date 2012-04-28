class SchoolUsersController < ApplicationController
  
  # GET /school_users
  # GET /school_users.json
  def index
    @school_users = SchoolUser.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @school_users }
    end
  end

  # GET /school_users/1
  # GET /school_users/1.json
  def show
    @school_user = SchoolUser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @school_user }
    end
  end

  # GET /school_users/new
  # GET /school_users/new.json
  def new
    @school_user = SchoolUser.new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @school_user }
    end
  end

  # GET /school_users/1/edit
  def edit
    @school_user = SchoolUser.find(params[:id])
    @user = @school_user.user
  end

  # POST /school_users
  # POST /school_users.json
  def create
    @school_user = SchoolUser.new(params[:school_user])
    @user = User.new(params[:user]) do |u|
      u.rolable = @school_user
    end
    
    valid = @user.valid? 
    valid = @school_user.valid? && valid
    
    respond_to do |format|
      if valid
        @school_user.save
        @user.save        
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
    @school_user = SchoolUser.find(params[:id])
    respond_to do |format|
      if @school_user.update_attributes(params[:school_user]) && @school_user.user.update_attributes(params[:user])
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
    @school_user = SchoolUser.find(params[:id])
    @school_user.user.destroy    
    @school_user.destroy

    respond_to do |format|
      format.html { redirect_to school_users_url }
      format.json { head :ok }
    end
  end

end