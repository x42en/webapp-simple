require './services/sockets'
require './services/chatService'
# <%End service requires%>

angular.module('webapp')
    .service 'devSocket', DevSocket
    .service 'chatSocket', ChatSocket
    .service 'chatService', ChatService
    # <%End service registration%>

