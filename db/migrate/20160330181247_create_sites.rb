class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :site_name
      t.string :site_slug
      t.string :site_base_url

      t.timestamps null: false
    end
  end
end
