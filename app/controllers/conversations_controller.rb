class ConversationsController < ApplicationController

  def index

  end

  def show
    @convo = Conversation.find(params[:id])
    @UC = UserConversation.find_by(conversation_id: @convo.id, user_id: current_user.id)
    @UC.lkp = Time.now
    @UC.save
    @messages = @convo.messages.order('created_at')
  end
end
