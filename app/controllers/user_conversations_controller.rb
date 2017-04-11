class UserConversationsController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    @convo = Conversation.new
    @UC1 = UserConversation.new
    @UC1.user = @user
    @UC1.conversation = @convo
    @UC2 = UserConversation.new
    @UC2.user = current_user
    @UC2.conversation = @convo
    if @UC2.save && @UC1.save && @convo.save
      redirect_to conversation_path(@convo)
    end
  end

end
