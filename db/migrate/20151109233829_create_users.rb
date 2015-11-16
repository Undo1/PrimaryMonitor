class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :link
      t.string :display_name
      t.integer :current_score
      t.string :profile_image

      t.timestamps null: false
    end
  end
end
