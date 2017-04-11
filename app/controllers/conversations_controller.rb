class ConversationsController < ApplicationController
  def show
    @convo = Conversation.find(params[:id])
    @messages = @convo.messages
  end
end
