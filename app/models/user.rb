class User < ActiveRecord::Base
  has_many :vote_counts
  belongs_to :election

  # Returns the Stack Exchange site user id. Hacky.
  def user_id
    return link.split("/")[2]
  end
end
