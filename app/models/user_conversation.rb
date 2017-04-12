class UserConversation < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  def unread_messages
    self.conversation.messages.select { |message| message.created_at > self.lkp }
  end
end
