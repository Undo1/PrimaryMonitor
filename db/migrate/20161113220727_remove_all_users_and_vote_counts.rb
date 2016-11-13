class RemoveAllUsersAndVoteCounts < ActiveRecord::Migration[5.0]
  def change
    VoteCount.destroy_all
    User.destroy_all
  end
end
