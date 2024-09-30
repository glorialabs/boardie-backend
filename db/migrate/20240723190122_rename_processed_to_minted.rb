class RenameProcessedToMinted < ActiveRecord::Migration[7.1]
  def change
    rename_column :submissions, :processed, :minted
  end
end
