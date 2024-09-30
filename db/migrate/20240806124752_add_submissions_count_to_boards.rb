class AddSubmissionsCountToBoards < ActiveRecord::Migration[7.1]
  def change
    add_column :boards, :submissions_count, :integer, default: 0
  end
end
