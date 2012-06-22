# encoding: utf-8
class TrainingsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :school_users_only
  before_filter :find_training, :only => [:show, :edit, :update, :destroy]
  respond_to :html, :json
  
  # GET /trainings
  # GET /trainings.json
  def index
    @trainings = Training.all
    respond_with @training
  end

  # GET /trainings/1
  # GET /trainings/1.json
  def show
    respond_with @training
  end

  # GET /trainings/new
  # GET /trainings/new.json
  def new
    @training = Training.new
    respond_with @training
  end

  # GET /trainings/1/edit
  def edit
    respond_with @training
  end

  # POST /trainings
  # POST /trainings.json
  def create
    @training = Training.new(params[:training])

    respond_to do |format|
      if @training.save
        format.html { redirect_to @training, notice: 'La formation a bien été créée.' }
        format.json { render json: @training, status: :created, location: @training }
      else
        format.html { render action: "new" }
        format.json { render json: @training.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /trainings/1
  # PUT /trainings/1.json
  def update
    respond_to do |format|
      if @training.update_attributes(params[:training])
        format.html { redirect_to @training, notice: 'La formation a bien été mise à jour.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @training.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trainings/1
  # DELETE /trainings/1.json
  def destroy
    @training.destroy

    respond_to do |format|
      format.html { redirect_to trainings_url }
      format.json { head :ok }
    end
  end
  
  private
  def find_training
    begin
      @training = Training.find(params[:id])
    rescue
      respond_to do |format|
        format.html { redirect_to trainings_path, alert: "Cette formation n'existe pas." }
        format.json { render head: :not_found }
      end
    end
  end
end
