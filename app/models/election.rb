class Election < ActiveRecord::Base
  belongs_to :site
  has_many :vote_counts
  has_many :users
end
