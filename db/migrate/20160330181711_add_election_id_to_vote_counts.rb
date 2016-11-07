class AddElectionIdToVoteCounts < ActiveRecord::Migration
  def change
    add_column :vote_counts, :election_id, :integer
  end
end
