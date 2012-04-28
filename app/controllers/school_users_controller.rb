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
  end

  # POST /school_users
  # POST /school_users.json
  def create
    @school_user = SchoolUser.new(params[:school_user])
    @user = User.new(params[:user]) do |u|
      u.rolable = @school_user
    end

    respond_to do |format|
      if @user.valid? && @school_user.valid?
        @school_user.save
        @user.save        
        format.html { redirect_to @school_user, notice: 'School user was successfully created.' }
        format.json { render json: @school_user, status: :created, location: @school_user }
      else
        format.html do 
          @user = User.new
          render action: "new"          
        end
        format.json { render json: @school_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /school_users/1
  # PUT /school_users/1.json
  def update
    @school_user = SchoolUser.find(params[:id])

    respond_to do |format|
      if @school_user.update_attributes(params[:school_user])
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
    @school_user.destroy

    respond_to do |format|
      format.html { redirect_to school_users_url }
      format.json { head :ok }
    end
  end
end
