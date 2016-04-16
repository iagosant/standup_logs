class Session < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :completeds, through: :users
  has_many :wips, through: :users
  has_many :blockers, through: :users

  def self.get_users(ids)
    @attendees = []
     ids.each do |id|
       @attendees << User.find(id)
     end
     @attendees
  end

end
