class ChatService
    constructor: (@Auth) ->
        @messages = []
        @username = ''
        @users = []
    
    login: (@username) ->
        @Auth.isLoggedIn = true
    
    addUser: (user, notif=false) ->
        if user not in @users
            @users.push user
            if notif
                @messages.push { 'author': 'system', 'msg': "#{user} entered the room..." }

    delUser: (user) ->
        if user in @users
            @users.splice @users.indexOf(user), 1
            @messages.push { 'author': 'system', 'msg': "#{user} left the room..." }

    getMessages: () -> @messages
    addMessage: (msg) -> @messages.push msg
    
    logout: () ->
        @Auth.isLoggedIn = false
        @username = ''
        @users = []
        @messages = []
