class User < ActiveRecord::Base
 has_and_belongs_to_many :sessions
 has_many :wips
 has_many :completeds
 has_many :blockers, dependent: :destroy

has_secure_password

 # attr_accessor :password
 # before_save :encrypt_password

 validates_confirmation_of :password
 validates_presence_of :password, :on => :create
 validates_presence_of :email
 # validates_uniqueness_of :email

 def encrypt_password

     def password=(password)

     self.password_digest = BCrypt::Password.create(password)

   end

   def is_password?(password)

     BCrypt::Password.new(self.password_digest) == password

   end

end
