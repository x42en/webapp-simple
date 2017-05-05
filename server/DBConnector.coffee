# Server = require("mongo-sync").Server
# Fiber  = require 'fibers'

# module.exports = class DBConnector
#     constructor: (host,db,collection) ->
#         host = host || '127.0.0.1'
#         unless db
#             throw 'Database not set.'
#         unless collection
#             throw 'Collection not set.'
#         Fiber(=>
#             server = new Server host
#             @_database = server.db db
#             @conn = @_database.getCollection collection
#         ).run()
        
#     setCollection: (collection) ->
#         @conn = @_database.setCollection collection

#     close: () ->
#         @_database.close()