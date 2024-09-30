class CreateBoards < ActiveRecord::Migration[7.1]
  def change
    create_table :boards do |t|
      t.string :name
      t.string :description
      t.integer :count
      t.boolean :enabled
      t.datetime :start_date
      t.integer :position
      t.json :extra
      t.string :notes

      t.timestamps
    end
  end
end
