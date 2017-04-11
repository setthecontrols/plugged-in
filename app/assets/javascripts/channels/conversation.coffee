App.room = App.cable.subscriptions.create "ConversationChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    html = $(data['message'])
    if data['id'].toString() == @current_user_id()
      html.addClass('left-align')
    else
      html.addClass('right-align')

    console.log(html)
    $('.messages').append html

  conversation_id: ->
    $('.message-list').attr('id')

  current_user_id: ->
    $('.messages').attr('id')

  speak: (data) ->

    @perform 'speak', data: data


$(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
  if event.keyCode is 13 # return = send
    data = {conversation_id: App.room.conversation_id(), message: event.target.value, user_id: App.room.current_user_id()}
    App.room.speak data
    event.target.value = ''
    event.preventDefault()


