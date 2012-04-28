class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name
  
  belongs_to :rolable, :polymorphic => true
  
  validates_presence_of :email, :rolable
  validates_presence_of :password, :on => :create
  validates_presence_of :password_confirmation, :on => :create
end
