class CreateElections < ActiveRecord::Migration
  def change
    create_table :elections do |t|
      t.string :site_id
      t.integer :election_number
      t.string :friendly_name

      t.timestamps null: false
    end
  end
end
