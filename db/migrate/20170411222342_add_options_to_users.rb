class AddOptionsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :band?, :boolean, null: false, default: false
    add_column :users, :venue?, :boolean, null: false, default: false
    add_column :users, :musician?, :boolean, null: false, default: false
  end
end
