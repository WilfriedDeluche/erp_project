class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name
  
  attr_accessor :skip_password_validation
  
  belongs_to :rolable, :polymorphic => true
  
  validates_presence_of :first_name, :last_name
  
  validates_presence_of :password_confirmation, :on => :create
  validate :skip_password, :on => :create

  def skip_password
    if self.skip_password_validation
      errors[:password].clear
      errors[:password_confirmation].clear
    end 
  end
end
