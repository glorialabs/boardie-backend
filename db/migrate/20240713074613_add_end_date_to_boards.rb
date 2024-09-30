class AddEndDateToBoards < ActiveRecord::Migration[7.1]
  def change
    add_column :boards, :end_date, :datetime
  end
end
