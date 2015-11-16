class CreateVoteCounts < ActiveRecord::Migration
  def change
    create_table :vote_counts do |t|
      t.integer :score
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
