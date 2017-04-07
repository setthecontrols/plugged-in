class CreateBoardposts < ActiveRecord::Migration[5.0]
  def change
    create_table :boardposts do |t|
      t.string :title
      t.text :content

      t.integer :user_id
      t.integer :boardcategory_id

      t.timestamps
    end
  end
end
