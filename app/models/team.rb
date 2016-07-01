class Team < ActiveRecord::Base
  has_many :users
  has_many :sessions
  validates :team_name, presence: true
  accepts_nested_attributes_for :users, :reject_if => lambda { |a| a[:content].blank? }

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/


end
