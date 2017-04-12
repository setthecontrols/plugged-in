class Message < ApplicationRecord
  after_create_commit { MessageBroadcastJob.perform_later self }
  after_create_commit :update_lkp

  belongs_to :conversation
  belongs_to :user

  def update_lkp
    @convo = self.conversation
    @user = self.user
    @UC = UserConversation.find_by(conversation_id: @convo.id, user_id: @user.id)
    @UC.lkp = Time.now
    if @UC.save
      puts "DUDE THIS WOKRED TOOO SDJFALAJSFLA;SFAS"
    end
  end
end
