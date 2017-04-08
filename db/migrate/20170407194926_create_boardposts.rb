class CreateBoardposts < ActiveRecord::Migration[5.0]
  def change
    create_table :boardposts do |t|
      t.string :title
      t.text :content

      t.references :user
      t.references :boardcategory

      t.timestamps
    end
  end
end
