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
    setTimeout: (@ellapsed) ->
    getMessage: -> @message
    getType: -> @type
    getIcon: ->
        unless @type
            return false
        switch @type
            when 'alert-success'
                icon = 'fa-check-circle'
                break
            when 'alert-info'
                icon = 'fa-info-circle'
                break
            when 'alert-warning'
                icon = 'fa-exclamation-triangle'
                break
            when 'alert-danger'
                icon = 'fa-times-circle'
                break
            else
                console.log "Unsupported type: #{@type}"
                icon = 'fa-question-circle'
                break
        return icon  

angular.module('webapp').service 'alertService', AlertService