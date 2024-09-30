class AddTransactionIdToSubmissions < ActiveRecord::Migration[7.1]
  def change
    add_column :submissions, :transaction_hash, :string
    remove_column :submissions, :minted
  end
end
