class Session < ActiveRecord::Base
  has_many :users
  has_many :wips
  has_many :completeds
  has_many :blockers
end
