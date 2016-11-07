class User < ActiveRecord::Base
  has_many :vote_counts
  belongs_to :election
end
