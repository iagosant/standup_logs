class Session < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :completeds, :dependent => :destroy
  has_many :wips, :dependent => :destroy
  has_many :blockers, :dependent => :destroy

  def self.get_users(ids)

    @attendees = []
     ids.each do |id|
       @attendees << User.find(id)
     end
     @attendees
  end
end
