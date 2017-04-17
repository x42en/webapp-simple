io     = require 'socket.io-client'
CONFIG = require './sockets.conf'

class SocketClient
    constructor: ($rootScope, host='localhost', port=8000, service='/',ssl=false) ->
        safeApply = (scope, fn) ->
            if scope.$$phase
                fn()
            else
                scope.$apply(fn)

        socket = io.connect "#{host}:#{port}#{service}", { reconnectionDelay: 2000, forceNew: true, secure: ssl }
        return {
            on: (eventName, callback) ->
                socket.on eventName, ->
                    args = arguments
                    safeApply($rootScope, () ->
                        callback.apply socket, args
                    )
            emit: (eventName, data, callback) ->
                socket.emit eventName, data, ->
                    args = arguments
                    safeApply($rootScope, () ->
                        if callback
                            callback.apply socket, args
                    )

            disconnect: () ->
                disconnecting = true
                socket.disconnect()
              
            socket: socket
        }

class DevSocket extends SocketClient
    constructor: ($rootScope, $location) ->
        location = $location.protocol() + "://" + $location.host()
        return super($rootScope, host=location, port=CONFIG.DEV_PORT)

class ChatSocket extends SocketClient
    constructor: ($rootScope) ->
        return super($rootScope, host=CONFIG.NODE_HOST, port=CONFIG.NODE_PORT, service='/chat')

# <%End sockets definition%>
