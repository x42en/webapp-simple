class ChatCtrl
    constructor: (@alertService, @chatSocket, @chatService) ->
        console.log '[+] Chat controller loaded'
        @name = @chatService.username
        @msg = ''

        # Receive new message
        @chatSocket.on 'err', (msg) =>
            @alertService.error msg

    # Send a message
    send: ->
        unless @msg
            @alertService.error 'Please write something ;)'
            return false

        # Build object
        infos = {}
        infos.author = @name
        infos.msg = @msg
        # Store message infos
        @chatService.messages.push infos
        @chatSocket.emit 'msg', infos
        # Reset message input
        @msg = ''

angular.module('webapp').controller 'ChatCtrl', ChatCtrl