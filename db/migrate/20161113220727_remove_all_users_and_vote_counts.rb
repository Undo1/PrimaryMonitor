class RemoveAllUsersAndVoteCounts < ActiveRecord::Migration[5.0]
  def change
    VoteCount.delete_all
    User.delete_all
  end
end
