class User < ActiveRecord::Base
 has_and_belongs_to_many :sessions
 has_many :wips
 has_many :completeds
 has_many :blockers, dependent: :destroy

end
