# encoding: utf-8
class PublicPagesController < ApplicationController
  def school
  end
  
  def news
    @events = Event.where(:klass_id => nil && :start_date > DateTime.now)
  end
  
  def contact
    @recruiters = Recruiter.all
  end
  
  def send_email
    unless (params[:mail].nil? || params[:mail][:first_name].empty? || params[:mail][:last_name].empty? || params[:mail][:email].empty? || 
        params[:mail][:recruiter_id].empty? || params[:mail][:subject].empty? || params[:mail][:message].empty?)
      begin
        mail = params[:mail]
        @recruiter = Recruiter.find(mail[:recruiter_id])
        raise RecordNotFound.new if @recruiter.user.nil?
        begin
          PublicMailer.invitation_email(mail[:email], @recruiter, mail[:last_name], mail[:first_name], 
              mail[:subject], mail[:message]).deliver
          respond_to do |format|
            format.html { redirect_to contact_public_pages_path, notice: "L'email a bien été envoyé au Chargé de Placement." }
            format.json { render head: :ok }
          end
        rescue
          cannot_send_email("Un problème est survenu pendant l'envoi de votre email.")
        end
      rescue
        cannot_send_email("Le Charge de Placement n'existe pas.")
      end
    else
      cannot_send_email("Vous devez remplir intégralement le formulaire afin d'envoyer un email")
    end
  end
  
  def cannot_send_email(message)
    respond_to do |format|
      format.html { redirect_to contact_public_pages_path, alert: message }
      format.json { render head: :unprocessable_entity }
    end
  end
end
