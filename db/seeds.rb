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
puts "#### SCHOOL USER ####"
school_user = SchoolUser.create!
user = User.create! :email => 'pedago@ingesup.com', :password => 'ingesup', :password_confirmation => 'ingesup', :first_name => 'Prenom', :last_name => 'Nom' do |u|
  u.rolable = school_user
  u.invitation_accepted_at = DateTime.now
end
puts user.first_name << " " << user.last_name << " as " << user.rolable_type

puts "#### TEACHER ####"
teacher = Teacher.create! :arrival_year => "2006"
user2 = User.create! :email => 'teacher@ingesup.com', :password => 'ingesup', :password_confirmation => 'ingesup', :first_name => 'Teacher', :last_name => 'Nom' do |u|
  u.rolable = teacher
  u.invitation_accepted_at = DateTime.now
end
puts user2.first_name << " " << user2.last_name << " as " << user2.rolable_type
