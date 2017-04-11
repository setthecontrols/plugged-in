class Conversation < ApplicationRecord
  has_many :user_conversations
  has_many :users, through: :user_conversations
  has_many :messages

  def other_user(current_user)
    self.users.find{ |user| user.id != current_user.id}
  end
end
