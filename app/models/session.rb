class Session < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :completeds
  has_many :wips
  has_many :blockers

  def self.get_users(ids)

    @attendees = []
     ids.each do |id|
       @attendees << User.find(id)
     end
     @attendees
  end
end
