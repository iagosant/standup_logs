class Team < ActiveRecord::Base
  has_many :users
  has_many :sessions, through: :users
  validates :team_name, presence: true
  accepts_nested_attributes_for :users, :reject_if => lambda { |a| a[:content].blank? }
end
