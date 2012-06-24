class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :find_current_class
  
  helper_method :teacher_signed_in?, :school_user_signed_in?, :student_signed_in?, :recruiter_signed_in?
  
  def after_sign_in_path_for(resource_name)
    home_index_path
  end
  
  def teacher_signed_in?
    @is_teacher_in = (user_signed_in? && current_user.rolable_type == "Teacher" && !current_user.rolable.nil?) ? true : false
    @is_teacher_in
  end
  
  def school_user_signed_in?
    @is_school_user_in = (user_signed_in? && current_user.rolable_type == "SchoolUser" && !current_user.rolable.nil?) ? true : false
    @is_school_user_in
  end
  
  def student_signed_in?
    @is_student_in = (user_signed_in? && current_user.rolable_type == "Student" && !current_user.rolable.nil?) ? true : false
    @is_student_in
  end
  
  def recruiter_signed_in?
    @is_recruiter_in = (user_signed_in? && current_user.rolable_type == "Recruiter" && !current_user.rolable.nil?) ? true : false
    @is_recruiter_in
  end
  
  def school_users_only
    access_denied unless current_user.rolable_type == "SchoolUser" && !current_user.rolable.nil?
  end
  
  def teachers_or_school_users_only
    access_denied unless %w(SchoolUser Teacher).include?(current_user.rolable_type) && !current_user.rolable.nil?
  end
  
  def admin_only
    access_denied unless current_user.is_admin
  end
  
  def recruiters_only
    access_denied unless current_user.rolable_type == "Recruiter" && !current_user.rolable.nil?
  end
  
  def access_denied
    respond_to do |format|
      format.html { redirect_to home_index_path, alert: "Acces interdit" }
    end    
  end
  
  def create_and_send_invitation(user, rolable, model_name)
    instance_name = model_name.underscore.gsub('_', ' ').capitalize
    begin
      rolable.save
      user.invite! do |u|
        u.invited_by_id = current_user.id
      end 
      respond_to do |format|
        format.html { redirect_to rolable, notice: "#{instance_name} was successfully created." }
        format.json { render json: rolable, status: :created, location: rolable }
      end
    rescue
      notice = "#{instance_name} was successfully created."
      invitation_failure(user, model_name, notice)
    end
  end
  
  def resend_invitation(user, model_name)
    begin
      user.invite! if user.invitation_accepted_at.nil?
      respond_to do |format|
        format.html{redirect_to url_for(:controller => model_name.to_s.underscore.pluralize, :action => 'index'), :notice => "Un email d'invitation vient d'etre envoye a l'utilisateur" }
      end
    rescue
      notice = nil
      invitation_failure(user, model_name, notice)
    end
  end
  
  def invitation_failure(user, model_name, notice)
    user.invitation_sent_at = nil # set to nil again to know that the email has not been sent
    user.save
    respond_to do |format|
      format.html { redirect_to url_for(:controller => model_name.to_s.underscore.pluralize, :action => 'index'), notice: notice , alert: "Un probleme est survenu lors de l'envoi de l'invitation. Contactez un administrateur." }
      format.json { render status: :internal_error }          
    end
  end
  
  def find_current_class
    return unless student_signed_in?
    @current_class = current_user.rolable.klasses.order("year DESC").first
  end
end
