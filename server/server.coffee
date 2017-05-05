IOServer = require 'ioserver'
CONFIG   = require './sockets.json'

app = new IOServer
        port: CONFIG.NODE_PORT
        host: 'localhost'

app.addService
    name: 'chat'
    service: Chat

# <%End services%>

app.start()
console.log '#[+] App started :)'
