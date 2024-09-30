class AddProcessedToSubmissions < ActiveRecord::Migration[7.1]
  def change
    add_column :submissions, :processed, :boolean
  end
end
