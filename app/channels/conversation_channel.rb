class ConversationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "some_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Message.create!(content: data['message'], )
    # ActionCable.server.broadcast 'some_channel', message: data['message']
  end
end
