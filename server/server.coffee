IOServer = require 'ioserver'
CONFIG   = require './sockets.json'

app = new IOServer
        port: CONFIG.NODE_PORT
        host: 'localhost'

app.addService
    name: 'chat'
    service: Chat

# <%End services%>

console.log '#[+] App started :)'
app.start()