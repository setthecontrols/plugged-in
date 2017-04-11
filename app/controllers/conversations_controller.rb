class ConversationsController < ApplicationController
  def show
    @convo = Conversation.find(params[:id])
    @messages = @convo.messages.order('created_at')
  end
end
