class PublicMailer < ActionMailer::Base
  # default from: "from@example.com"
  
  def invitation_email(from, recruiter, last_name, first_name, subject, message)
    @message = message
    @last_name = last_name.upcase
    @first_name = first_name.capitalize
    @recruiter = recruiter
    
    mail(:from => "#{@first_name} #{@last_name}<#{from}>",
          :to => @recruiter.user.email,
          :subject => subject)
  end
  
  def student_email(student, sender, subject, message)
    debugger
    @message = message
    
    mail(:from => "#{sender.first_name} #{sender.last_name}<#{sender.email}>",
          :to => student.user.email,
          :subject => subject)
  end
end
