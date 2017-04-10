class AddForeignKeyToLocations < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :locations, :users
  end
end
