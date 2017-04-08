class AddAttachmentImageToBoardposts < ActiveRecord::Migration
  def self.up
    change_table :boardposts do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :boardposts, :image
  end
end
