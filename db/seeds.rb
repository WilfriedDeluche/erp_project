#encoding: UTF-8

# Initialize every resource
User.destroy_all
SchoolUser.destroy_all
Teacher.destroy_all
Recruiter.destroy_all
Student.destroy_all
Company.destroy_all

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

puts "#### SCHOOL USER ####"
school_user = SchoolUser.create!
user = User.create! :email => 'pedago@ingesup.com', :password => 'ingesup', :password_confirmation => 'ingesup', :first_name => 'Mamadou', :last_name => 'Koulibali' do |u|
  u.rolable = school_user
  u.invitation_accepted_at = DateTime.now
end
puts user.first_name << " " << user.last_name << " as " << user.rolable_type

puts "#### RECRUITER ####"
recruiter = Recruiter.create! :arrival_date => "03/06/2011"
user = User.create! :email => 'recruiter@ingesup.com', :password => 'ingesup', :password_confirmation => 'ingesup', :first_name => 'Audrey', :last_name => 'Tauchon' do |u|
  u.rolable = recruiter
  u.invitation_accepted_at = DateTime.now
end
puts user.first_name << " " << user.last_name << " as " << user.rolable_type

puts "#### TEACHER ####"
teacher = Teacher.create! :arrival_year => "2006"
user2 = User.create! :email => 'teacher@ingesup.com', :password => 'ingesup', :password_confirmation => 'ingesup', :first_name => 'Marie', :last_name => 'Verriere' do |u|
  u.rolable = teacher
  u.invitation_accepted_at = DateTime.now
end
puts user2.first_name << " " << user2.last_name << " as " << user2.rolable_type

puts "#### STUDENT ####"
student = Student.create! :birthdate => "01/02/1989", :address => "21, avenue Victor Hugo", :zip_code => "75020", :city => "PARIS", :mobile_phone_number => "0688383885"
user3 = User.create! :email => 'student@ingesup.com', :password => 'ingesup', :password_confirmation => 'ingesup', :first_name => 'Jean', :last_name => 'Dupond' do |u|
  u.rolable = student
  u.invitation_accepted_at = DateTime.now
end
puts user3.first_name << " " << user3.last_name << " as " << user3.rolable_type


puts 'SETTING UP DEFAULT COMPANIES'
puts "..."
company1 = Company.create! :corporate_name => "Applidget", :address => "68, rue du Château d'Eau", :zip_code => "75010", :city => "PARIS",
  :phone_number => "0123456789", :contact_first_name => "Tristan", :contact_last_name => "Verdier", :contact_email => "tristan.verdier@applidget.com"
puts company1.corporate_name

company2 = Company.create! :corporate_name => "Cap Gemini", :address => "Tour Europlaza 20, avenue André-Prothin", :zip_code => "92927", :city => "Paris-La Défense Cedex",
  :phone_number => "0149673000"
puts company2.corporate_name
  
