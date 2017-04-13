App.room = App.cable.subscriptions.create "ConversationChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    html = $(data['message'])
    if data['id'].toString() == @current_user_id()
      $(html[0].children[0]).addClass('left')
      $(html[0].children[1]).addClass('left')

    else
      debugger
      $(html[0].children[0]).addClass('right')
      $(html[0].children[1]).addClass('right absolute')

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
