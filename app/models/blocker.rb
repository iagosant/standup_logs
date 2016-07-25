class Blocker < ActiveRecord::Base
  belongs_to :user, validate: true
  acts_as_taggable
end
