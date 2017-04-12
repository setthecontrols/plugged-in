class AddLkpToUserConversations < ActiveRecord::Migration[5.0]
  def change
    add_column :user_conversations, :lkp, :time
  end
end
