class Blocker < ActiveRecord::Base
  belongs_to :user, validate: true
end
