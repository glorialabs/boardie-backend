class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :submissions do |t|
      t.string :address
      t.string :ip
      t.json :request_details
      t.references :board, null: false, foreign_key: true

      t.timestamps
    end
  end
end
