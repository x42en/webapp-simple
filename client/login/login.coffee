class LoginCtrl
    constructor: (@$state, @alertService, @chatSocket, @chatService) ->
        console.log "[+] Login controller loaded"
        @username = undefined
        
        # Authentication is successful
        @chatSocket.on 'join', (name) =>
            @chatService.login name
            @$state.go 'chat'
            
        # Got an error
        @chatSocket.on 'err', (msg) =>
            @alertService.error msg
    
    # Try to authenticate
    auth: ->
        @chatSocket.emit 'auth', @username

angular.module('webapp').controller 'LoginCtrl', LoginCtrl