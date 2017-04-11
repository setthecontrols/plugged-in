class ConversationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "some_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Message.create!(content: data['data']['message'], user_id: data['data']['user_id'].to_i, conversation_id: data['data']['conversation_id'].to_i)
    # ActionCable.server.broadcast 'some_channel', message: data['message']
  end
end
