# encoding: utf-8
class StudentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :school_users_only, :except => [:show, :index]
  before_filter :find_class, :only => [:show]
  before_filter :find_student, :only => [:show, :edit, :update, :destroy, :reinvite_user, :new_class, :contact, :send_mail]
  before_filter :own_recruiter_only, :only => [:show]
  respond_to :html, :json
  
  # GET /students
  # GET /students.json
  def index
    unless current_user.is_recruiter?
      @students = Student.order("created_at ASC").select { |s| s unless s.user.nil? }
    else
      @students = current_user.rolable.recruitments.where(:end_date => nil).map { |recruitment| recruitment.student }
    end
    respond_with @students
  end

  # GET /students/1
  # GET /students/1.json
  def show
    @current_recruiter = @student.recruitments.order("start_date DESC").first
    @recruiters_count = @student.recruitments.count
    @current_contract = @student.contracts.where("start_date < '#{Date.today}' AND end_date > '#{Date.today}'").first
    @contracts_count = @student.contracts.count
    @current_class = @student.klasses.order("year DESC").first
    respond_with @student
  end

  # GET /students/new
  # GET /students/new.json
  def new
    @student = Student.new
    @user = User.new
    respond_with @student
  end

  # GET /students/1/edit
  def edit
    @user = @student.user
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(params[:student])
    @user = User.new(params[:user]) do |u|
      u.rolable = @student
      u.skip_password_validation = true
    end
    
    valid = @user.valid? 
    valid = @student.valid? && valid
    
    if valid
      create_and_send_invitation(@user, @student, "Student")
    else
      respond_to do |format|
        format.html { render action: "new" }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /students/1
  # PUT /students/1.json
  def update
    @user = @student.user
    respond_to do |format|
      if params[:student][:klass_ids]
        begin
          klass = Klass.find(params[:student][:klass_ids])
          @dobloon_year = @student.klasses.detect { |k| k.year == klass.year }
          @student.klasses.delete(@dobloon_year) if @dobloon_year
          @student.klasses << klass
          format.html { redirect_to student_path(@student), :notice => "Nouvel assignement" }
        rescue
          format.html { redirect_to new_class_student_path(@student), :alert => "La classe choisie n'existe pas" }
        end
      elsif @student.update_attributes(params[:student]) && @user.update_attributes(params[:user])
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.user.destroy
    @student.destroy

    respond_to do |format|
      format.html { redirect_to students_url }
      format.json { head :ok }
    end
  end
  
  # PUT /students/1/reinvite_user
  def reinvite_user
    resend_invitation(@student.user, "Student")
  end
  
  # GET /students/1/new_class
  def new_class
    @student_classes = @student.klasses.order("year DESC")
    @classes = Klass.order("year DESC")
    respond_with @student
  end
  
  # POST /students/1/contact
  def contact
    @subject = ""
    @message = ""
    respond_with @student
  end
  
  # POST /students/1/send_mail
  def send_mail
    @subject = params[:mail][:subject]
    @message = params[:mail][:message]
    unless (@subject.empty? || @message.empty?)
      begin
        PublicMailer.student_email(@student, current_user, @subject, @message).deliver
        respond_to do |format|
          format.html { redirect_to students_path, notice: "L'email a bien été envoyé à l'étudiant." }
        end
      rescue
        respond_to do |format|
          format.html do 
            flash[:alert] = "Un problème est survenu pendant l'envoi de votre email."
            render action: "contact"
          end
        end
      end
    else
      respond_to do |format|
        format.html do 
          flash[:alert] = "Vous devez remplir intégralement le formulaire afin d'envoyer un email."
          render action: "contact"
        end
      end
    end
  end
  
  private
  def find_student
    begin
      if @class
        @student = @class.students.find(params[:id])
      else
        @student = Student.find(params[:id])
      end
      raise RecordNotFound.new if @student.user.nil?
    rescue
      respond_to do |format|
        format.html { redirect_to students_path, alert: 'Student does not exist.' }
        format.json { render head: :not_found }
      end
    end
  end
  
  def own_recruiter_only
    return unless current_user.is_recruiter?
    unless current_user.rolable.recruitments.where(:student_id => @student.id, :end_date => nil).any?
      respond_to do |format|
        format.html { redirect_to students_path, alert: 'You are not in charge of this student.' }
        format.json { render head: :not_found }
      end 
    end
  end
  
  def find_class
    return unless params[:class_id]
    begin
      @class = Klass.find(params[:class_id])
    rescue
      respond_to do |format|
        format.html { redirect_to classes_path, alert: "Cette classe n'existe pas." }
        format.json { render head: :not_found }
      end
    end
  end
end
