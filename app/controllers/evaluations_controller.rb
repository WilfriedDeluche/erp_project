# encoding: utf-8
class EvaluationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :school_users_only, :except => [:show, :index]
  before_filter :find_evaluation, :only => [:show, :edit, :update, :destroy]
  respond_to :html, :json
  
  # GET /evaluations
  # GET /evaluations.json
  def index
    @evaluations = Evaluation.all
    respond_with @evaluations
  end

  # GET /evaluations/1
  # GET /evaluations/1.json
  def show
    respond_with @evaluation
  end

  # GET /evaluations/new
  # GET /evaluations/new.json
  def new
    @evaluation = Evaluation.new
    respond_with @evaluation
  end

  # GET /evaluations/1/edit
  def edit
    respond_with @evaluation
  end

  # POST /evaluations
  # POST /evaluations.json
  def create
    @evaluation = Evaluation.new(params[:evaluation])

    respond_to do |format|
      if @evaluation.save
        format.html { redirect_to @evaluation, notice: "L'évaluation a été créée avec succès." }
        format.json { render json: @evaluation, status: :created, location: @evaluation }
      else
        format.html { render action: "new" }
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /evaluations/1
  # PUT /evaluations/1.json
  def update
    respond_to do |format|
      if @evaluation.update_attributes(params[:evaluation])
        format.html { redirect_to @evaluation, notice: "L'évaluation a été mise à jour avec succès." }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /evaluations/1
  # DELETE /evaluations/1.json
  def destroy
    @evaluation.destroy

    respond_to do |format|
      format.html { redirect_to evaluations_url }
      format.json { head :ok }
    end
  end
  
  def find_evaluation
    begin
      @evaluation = Evaluation.find(params[:id])
    rescue
      respond_to do |format|
        format.html { redirect_to evaluations_path, alert: "L'évaluation n'existe pas." }
        format.json { render head: :not_found }
      end
    end
  end
end
