class AddElectionIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :election_id, :integer
  end
end
