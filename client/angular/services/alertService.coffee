class AlertService
    constructor: ->
        @type = undefined
        @message = undefined
        @ellapsed = 3000
        
    success: (@message) ->
        console.log @message
        @type = "alert-success"
        @hide()
    info: (@message) ->
        console.info @message
        @type = "alert-info"
        @hide()
    warning: (@message) ->
        console.warn @message
        @type = "alert-warning"
        @hide()
    error: (@message) ->
        console.error @message
        @type = "alert-danger"
        @hide()
    hide: ->
        # Clean message after 3 seconds
        setTimeout(=>
            @message = undefined
            @type = undefined
        , @ellapsed)
    getMessage: -> @message
    getType: -> @type
    getIcon: ->
        if @type is 'alert-success'
            return 'fa-check-circle'
        else if @type is 'alert-info'
            return 'fa-info-circle'
        else if @type is 'alert-warning'
            return 'fa-exclamation-circle'
        else
            return 'fa-warning'   

angular.module('webapp').service 'alertService', AlertService