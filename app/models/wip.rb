class Wip < ActiveRecord::Base
  belongs_to :user
  validates_uniqueness_of :user_id, scope: [:session_id]
end
