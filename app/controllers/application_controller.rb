class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :teacher_signed_in?, :school_user_signed_in?
  
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
  
  def school_users_only
    access_denied unless current_user.rolable_type == "SchoolUser" && !current_user.rolable.nil?
  end
  
  def access_denied
    respond_to do |format|
      format.html { redirect_to home_index_path, alert: "Acces interdit" }
    end    
  end
end
