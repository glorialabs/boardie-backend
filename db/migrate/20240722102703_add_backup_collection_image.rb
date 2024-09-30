class AddBackupCollectionImage < ActiveRecord::Migration[7.1]
  def change
    add_column :collection_infos, :backup_collection_image, :string
  end
end
