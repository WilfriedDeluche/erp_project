# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

# Initialize every resource
User.destroy_all

puts 'SETTING UP DEFAULT USERS'
user = User.create! :email => 'admin@ingesup.com', 
                    :password => 'ingesup', 
                    :password_confirmation => 'ingesup',
                    :first_name => 'Admin', 
                    :last_name => 'Ingesup'
