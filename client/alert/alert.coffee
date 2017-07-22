class AlertCtrl
    constructor: (@alertService) ->
    getMessage: -> @alertService.getMessage()
    getType: -> @alertService.getType()
    getIcon: -> @alertService.getIcon()
    hide: -> @alertService.hide()


angular.module('webapp').controller 'AlertCtrl', AlertCtrl
