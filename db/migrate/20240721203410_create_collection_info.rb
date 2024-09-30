class CreateCollectionInfo < ActiveRecord::Migration[7.1]
  def change
    create_table :collection_infos do |t|
      t.string :collection_hash
      t.float :all_time_volume
      t.float :seven_days_volume
      t.float :one_day_volume
      t.float :floor_price
      t.float :top_bid
      t.integer :unique_owners_count
      t.string :creator_address
      t.string :name
      t.integer :current_supply
      t.string :uri
      t.string :slug
      t.string :collection_image
      t.boolean :is_verified
      t.float :one_day_change_percent
      t.float :seven_days_change_percent

      t.timestamps
    end
  end
end
