# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

# Initialize every resource
User.destroy_all

puts 'SETTING UP DEFAULT USERS'
puts "..."
puts "#### SCHOOL USER ####"
school_user = SchoolUser.create! :position => "Directeur des Etudes"
user = User.create! :email => 'admin@ingesup.com', :password => 'ingesup', :password_confirmation => 'ingesup', :first_name => 'Prenom', :last_name => 'Nom' do |u|
  u.rolable = school_user
end
puts user.first_name << " " << user.last_name << " as " << user.rolable_type << " - " << user.rolable.position

puts "#### TEACHER ####"
teacher = Teacher.create! :arrival_year => "2006"
user2 = User.create! :email => 'teacher@ingesup.com', :password => 'ingesup', :password_confirmation => 'ingesup', :first_name => 'Teacher', :last_name => 'Nom' do |u|
  u.rolable = teacher
end
puts user2.first_name << " " << user2.last_name << " as " << user2.rolable_type
