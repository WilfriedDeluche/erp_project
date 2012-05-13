class CompaniesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :recruiters_only
  before_filter :find_company, :only => [:show, :edit, :update, :destroy]
  respond_to :html, :json
  
  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.all
    respond_with @companies
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    respond_with @company
  end

  # GET /companies/new
  # GET /companies/new.json
  def new
    @company = Company.new
    respond_with @company
  end

  # GET /companies/1/edit
  def edit
    respond_with @company
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(params[:company])

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render json: @company, status: :created, location: @company }
      else
        format.html { render action: "new" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy

    respond_to do |format|
      format.html { redirect_to companies_url }
      format.json { head :ok }
    end
  end
  
  private
  def find_company
    begin
      @company = Company.find(params[:id])
    rescue
      respond_to do |format|
        format.html { redirect_to companies_path, alert: 'Company does not exist.' }
        format.json { render head: :not_found }
      end
    end
  end
end
