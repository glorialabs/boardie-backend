class AddCoverUrlToBoards < ActiveRecord::Migration[7.1]
  def change
    add_column :boards, :cover_url, :string
  end
end
