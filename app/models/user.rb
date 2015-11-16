class User < ActiveRecord::Base
  has_many :vote_counts
end
