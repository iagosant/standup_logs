class User < ActiveRecord::Base
 has_secure_password

 has_and_belongs_to_many :sessions
 has_many :wips
 has_many :completeds
 has_many :blockers, dependent: :destroy

 # before_save :encrypt_password

 validates_confirmation_of :password
 validates_presence_of :password, :on => :create
 validates_presence_of :email
 # validates_uniqueness_of :email

end
