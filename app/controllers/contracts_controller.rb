class ContractsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :recruiters_only
  before_filter :find_student
  before_filter :find_contract, :only => [:show, :edit, :update, :destroy]
  respond_to :html, :json
  
  # GET /contracts
  # GET /contracts.json
  def index
    @contracts = @student.contracts
    respond_with @contracts
  end

  # GET /contracts/1
  # GET /contracts/1.json
  def show
    respond_with @contract
  end

  # GET /contracts/new
  # GET /contracts/new.json
  def new
    @contract = Contract.new
    @companies = Company.all
    respond_with @contract
  end

  # GET /contracts/1/edit
  def edit
    @companies = Company.all
    respond_with @contract
  end

  # POST /contracts
  # POST /contracts.json
  def create
    @contract = @student.contracts.build(params[:contract]) do |c|
      c.recruiter = @student.recruitments.order("start_date DESC").first.recruiter
    end
    
    respond_to do |format|
      if @contract.save
        format.html { redirect_to student_contract_path(@student, @contract), notice: 'Contract was successfully created.' }
        format.json { render json: @contract, status: :created, location: @contract }
      else
        format.html do 
          @companies = Company.all
          render action: "new"
        end
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contracts/1
  # PUT /contracts/1.json
  def update
    respond_to do |format|
      if @contract.update_attributes(params[:contract])
        format.html { redirect_to student_contract_path(@student, @contract), notice: 'Contract was successfully updated.' }
        format.json { head :ok }
      else
        format.html do
          @companies = Company.all
          render action: "edit"
        end
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contracts/1
  # DELETE /contracts/1.json
  def destroy
    @contract.destroy

    respond_to do |format|
      format.html { redirect_to student_contracts_path(@student) }
      format.json { head :ok }
    end
  end
  
  private
  def find_student
    begin
      @student = Student.find(params[:student_id])
      raise RecordNotFound.new if @student.user.nil?
    rescue
      respond_to do |format|
        format.html { redirect_to students_path, alert: 'Student does not exist.' }
        format.json { render head: :not_found }
      end
    end
  end
  
  def find_contract
    begin
      @contract = @student.contracts.find(params[:id])
    rescue
      respond_to do |format|
        format.html { redirect_to student_contracts_path(@student), alert: 'Contract does not exist.' }
        format.json { render head: :not_found }
      end
    end
  end
end
