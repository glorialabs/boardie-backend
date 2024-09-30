class AddDefaultToExtra < ActiveRecord::Migration[7.1]
  def change
    change_column :boards, :extra, :json, default: {}
  end
end
