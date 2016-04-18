class User < ActiveRecord::Base
 has_and_belongs_to_many :sessions
 has_many :wips
 has_many :completeds
 has_many :blockers, dependent: :destroy
 # scope :not_attended, where(attended: false)
 # scope :attended, where(attended: true)
 # scope :recent, order("created_at desc").limit(3)
end
