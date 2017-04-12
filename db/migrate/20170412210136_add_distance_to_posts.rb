class AddDistanceToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :boardposts, :distance, :float
  end
end
