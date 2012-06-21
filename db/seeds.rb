#encoding: UTF-8

# Initialize every resource
User.destroy_all
SchoolUser.destroy_all
Teacher.destroy_all
Recruiter.destroy_all
Student.destroy_all
Company.destroy_all
Recruitment.destroy_all
Contract.destroy_all
Training.destroy_all

first_names = %w(AURELIE LAETITA ALAIN NICOLAS FELICIA IGNACIO ELODIE ARTHUR LAURENCE MARIE PATRICIA AURELIE MATHIEU LINDA LISA JENNIFER JEAN FRANCOIS MICHAEL WILLIAM DAVID RICHARD CHARLES THOMAS)
last_names = %w(MARTIN DUPONT JANVIER BERGER DUJARDIN LEMAITRE VIARD COTILLARD MOUNIER HERAUT BOUYER SARDIN RIVERIN GOMES FERRERA VIGNAUT WAGNER ZEPETA AGUILA BRIANCON DUCHOMMIER)
companies_name = ["APPLIDGET", "CAPGEMINI", "LOREAL", "SUBWAY", "AIRLIQUIDE", "MICROSOFT", "APPLE", "GOOGLE", "PRESTANCE", "YSANCE"]
contracts = %w(contrat_pro stage apprentissage)
trainings = { "Système d'Ingénierie et Génie Logiciel" => "SIGL", 
              "Temps Réel et Systèmes Embarqués" => "TRSE", 
              "Systèmes, Réseaux et Télécommunication" => "SRT" }


puts "#### ALL DATAS FROM CURRENT DATABASE DESTROYED ####"

puts 'SETTING UP DEFAULT USERS'
puts "..."
puts "#### SCHOOL USER ADMIN ####"
school_user = SchoolUser.create!
user = User.create! :email => 'admin-pedago@ingesup.com', :password => 'ingesup', :password_confirmation => 'ingesup', :first_name => 'Jean', :last_name => 'Martin' do |u|
  u.rolable = school_user
  u.invitation_accepted_at = DateTime.now
  u.is_admin = true
end
puts user.first_name << " " << user.last_name << " as " << user.rolable_type

puts "#### SCHOOL USERS ####"

school_user = SchoolUser.create!
user = User.create! :email => 'pedago@ingesup.com', :password => 'ingesup', :password_confirmation => 'ingesup', :first_name => 'Mamadou', :last_name => 'Koulibali' do |u|
  u.rolable = school_user
  u.invitation_accepted_at = DateTime.now
end
puts user.first_name << " " << user.last_name << " as " << user.rolable_type

10.times do |n|
  first_name = first_names.sample
  last_name = last_names.sample
  school_user = SchoolUser.create!
  user = User.create! :email => "#{first_name.downcase}.#{last_name.downcase}#{n}.pedago@ingesup.com", :password => 'ingesup', :password_confirmation => 'ingesup', :first_name => "#{first_name.capitalize}", :last_name => "#{last_name.capitalize}" do |u|
    u.rolable = school_user
    u.invitation_accepted_at = DateTime.now
  end
end
puts "10 other School Users"

puts "#### RECRUITERS ####"
recruiter = Recruiter.create! :arrival_date => "03/06/2011"
user = User.create! :email => 'recruiter@ingesup.com', :password => 'ingesup', :password_confirmation => 'ingesup', :first_name => 'Audrey', :last_name => 'Tauchon' do |u|
  u.rolable = recruiter
  u.invitation_accepted_at = DateTime.now
end
puts user.first_name << " " << user.last_name << " as " << user.rolable_type

7.times do |n|
  first_name = first_names.sample
  last_name = last_names.sample
  recruiter = Recruiter.create! :arrival_date => "03/06/2011"
  user = User.create! :email => "#{first_name.downcase}.#{last_name.downcase}#{n}.recruiter@ingesup.com", :password => 'ingesup', :password_confirmation => 'ingesup', :first_name => "#{first_name.capitalize}", :last_name => "#{last_name.capitalize}" do |u|
    u.rolable = recruiter
    u.invitation_accepted_at = DateTime.now
  end
end
puts "7 other Recruiters"

puts "#### TEACHERS ####"
teacher = Teacher.create! :arrival_year => "2006"
user2 = User.create! :email => 'teacher@ingesup.com', :password => 'ingesup', :password_confirmation => 'ingesup', :first_name => 'Marie', :last_name => 'Verriere' do |u|
  u.rolable = teacher
  u.invitation_accepted_at = DateTime.now
end
puts user2.first_name << " " << user2.last_name << " as " << user2.rolable_type

25.times do |n|
  first_name = first_names.sample
  last_name = last_names.sample
  teacher = Teacher.create! :arrival_year => "2006"
  user2 = User.create! :email => "#{first_name.downcase}.#{last_name.downcase}#{n}.teacher@ingesup.com", :password => 'ingesup', :password_confirmation => 'ingesup', :first_name => "#{first_name.capitalize}", :last_name => "#{last_name.capitalize}" do |u|
    u.rolable = teacher
    u.invitation_accepted_at = DateTime.now
  end
end
puts "25 other Teachers"

puts "#### STUDENTS ####"
student = Student.create! :birthdate => "01/02/1989", :address => "21, avenue Victor Hugo", :zip_code => "75020", :city => "PARIS", :mobile_phone_number => "0688383885"
user3 = User.create! :email => 'student@ingesup.com', :password => 'ingesup', :password_confirmation => 'ingesup', :first_name => 'Jean', :last_name => 'Dupond' do |u|
  u.rolable = student
  u.invitation_accepted_at = DateTime.now
end
puts user3.first_name << " " << user3.last_name << " as " << user3.rolable_type

60.times do |n|
  first_name = first_names.sample
  last_name = last_names.sample
  student = Student.create! :birthdate => "01/02/1989", :address => "21, avenue Victor Hugo", :zip_code => "75020", :city => "PARIS", :mobile_phone_number => "0688383885"
  user3 = User.create! :email => "#{first_name.downcase}.#{last_name.downcase}#{n}@ingesup.com", :password => 'ingesup', :password_confirmation => 'ingesup', :first_name => "#{first_name.capitalize}", :last_name => "#{last_name.capitalize}" do |u|
    u.rolable = student
    u.invitation_accepted_at = DateTime.now
  end
end
puts "60 other Students"

puts 'SETTING UP DEFAULT COMPANIES'
puts "..."
companies_name.each do |name|
  first_name = first_names.sample
  last_name = last_names.sample
  company = Company.create! :corporate_name => name, :address => "68, rue du Château d'Eau", :zip_code => "75010", :city => "PARIS",
    :phone_number => "0123456789", :contact_first_name => "#{first_name.capitalize}", :contact_last_name => "#{last_name.capitalize}", :contact_email => "#{first_name.downcase}.#{last_name.downcase}@#{name.downcase}.com"
  puts company.corporate_name
end
  
puts "SETTING UP ONE RECRUITER TO STUDENTS ONE CONTRACT BETWEEN STUDENTS AND COMPANIES"
puts "..."
recruiters = Recruiter.all
nb_rec = recruiters.size
companies = Company.all
nb_comp = companies.size

Student.all.each do |student|
  random_recruiter = recruiters[rand(0..nb_rec-1)]
  rs = Recruitment.create! :student_id => student.id, :recruiter_id => random_recruiter.id, :start_date => DateTime.now
  puts rs.student.user.first_name << " " << rs.student.user.last_name << "'s current recruiter is " << rs.recruiter.user.first_name << " " << rs.recruiter.user.last_name

  to_contract = rand(0..1)
  if to_contract == 1
    type_contract = contracts.sample
    random_company = companies[rand(0..nb_comp-1)]
    contract = Contract.create! :student_id => student.id, :recruiter_id => random_recruiter.id, :company_id => random_company.id, 
        :start_date => Date.today - 250.days, :end_date => Date.today + 120.days, :kind => type_contract
    puts contract.student.user.first_name << " " << contract.student.user.last_name << " en contrat avec " << contract.company.corporate_name
  end
end

puts "..."
puts "SETTING UP TRAININGS"
puts "..."
if trainings.any?
  trainings.each do |name, section|
    3.times do |n|
      t = Training.create! :name => name, :section => section, :level => n+1
      puts "Formation #{t.name} : #{t.section}#{t.level}"
    end
  end
end
