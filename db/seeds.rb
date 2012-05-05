# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

# Initialize every resource
User.destroy_all
SchoolUser.destroy_all
Teacher.destroy_all

puts "#### ALL DATAS FROM CURRENT DATABASE DESTROYED ####"

puts 'SETTING UP DEFAULT USERS'
puts "..."
puts "#### SCHOOL USER ADMIN ####"
school_user = SchoolUser.create!
user = User.create! :email => 'admin-pedago@ingesup.com', :password => 'ingesup', :password_confirmation => 'ingesup', :first_name => 'Jean', :last_name => 'Martin' do |u|
  u.rolable = school_user
  u.is_admin = true
end
puts user.first_name << " " << user.last_name << " as " << user.rolable_type

puts "#### SCHOOL USER####"
school_user = SchoolUser.create!
user = User.create! :email => 'pedago@ingesup.com', :password => 'ingesup', :password_confirmation => 'ingesup', :first_name => 'Jean', :last_name => 'Martin' do |u|
  u.rolable = school_user
  u.is_admin = false
end
puts user.first_name << " " << user.last_name << " as " << user.rolable_type

puts "#### TEACHER ####"
teacher = Teacher.create! :arrival_year => "2006"
user2 = User.create! :email => 'teacher@ingesup.com', :password => 'ingesup', :password_confirmation => 'ingesup', :first_name => 'Marie', :last_name => 'Verriere' do |u|
  u.rolable = teacher
end
puts user2.first_name << " " << user2.last_name << " as " << user2.rolable_type

puts "#### STUDENT ####"
student = Student.create! :birthdate => "01/02/1989", :address => "21, avenue Victor Hugo", :zip_code => "75020", :city => "PARIS", :mobile_phone_number => "0688383885"
user3 = User.create! :email => 'student@ingesup.com', :password => 'ingesup', :password_confirmation => 'ingesup', :first_name => 'Jean', :last_name => 'Dupond' do |u|
  u.rolable = student
end
puts user3.first_name << " " << user3.last_name << " as " << user3.rolable_type
