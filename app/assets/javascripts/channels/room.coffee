App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    # 通信が確立された時

  disconnected: ->
    # Called when the subscription has been terminated by the server
    # 通信が切断された時

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    # サーバーサイドから値を受け取る
    $('#posts').append("<p>"+data["message"]+"</p>"); # 投稿を追加

  speak: (message) ->
    @perform 'speak', message: message　#サーバーサイドのspeakアクションにmessageパラメータを渡す

jQuery(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
  if event.keyCode is 13 # return キーのキーコードが13
    App.room.speak [event.target.value, $('[data-user]').attr('data-user'), $('[data-room]').attr('data-room')] # speak メソッド, event.target.valueを引数に.
    event.target.value = ''
    event.preventDefault()