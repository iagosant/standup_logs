class User < ActiveRecord::Base

 has_secure_password

 has_and_belongs_to_many :sessions
 has_many :wips
 has_many :completeds
 has_many :blockers, dependent: :destroy

 validates_confirmation_of :password
 validates_presence_of :password, :on => :create
 validates_presence_of :email
 # validates_uniqueness_of :email

 # validates :role, presence: true, inclusion: { in: ["master", "admin", "manager", "employee"] }
 # enum role: [:master => 0, :admin => 1, :manager => 2, :employee => 3]
 enum role: [:master, :admin, :manager, :employee]
 after_initialize :set_default_role, :if => :new_record?

 def set_default_role
  #  byebug
   self.role ||= :employee
 end

end
