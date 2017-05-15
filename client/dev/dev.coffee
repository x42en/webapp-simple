class DevCtrl
    
    states = []
    controllers = []
    views = {}
    show = false
    infos = undefined
    name = undefined
    cname = undefined
    calias = undefined
    salias = undefined
    slug = undefined
    state = undefined
    view = undefined
    module = undefined
    
    constructor: ($scope, @devSocket, @alertService, @$timeout, _) ->
        console.info "..:: Dev controller started ::.."
        console.info "-> Remove it on prod by setting '\"PRODUCTION\": true' in your app.config.json file and restart gulp ..."
        @authentified = false
        @controller = false

        $scope.$on '$destroy', () =>
            @devSocket.disconnect()
        
        # Retrieve infos on start
        @devSocket.emit 'infos'

        @devSocket.on 'states', (infos) =>
            @states = infos.states
            @controllers = infos.controllers
            @views = infos.views

        @devSocket.on 'refresh', =>
            location.reload()
        
        @devSocket.on 'success', (msg) =>
            @alertService.success "Dev: #{msg}"
        
        @devSocket.on 'notification', (msg) =>
            @alertService.info "Dev notification: #{msg}"
        
        @devSocket.on 'warning', (msg) =>
            @alertService.warning "Dev warning: #{msg}"
        
        @devSocket.on 'err', (msg) =>
            @alertService.error "Dev error: #{msg}"
        
        @devSocket.on 'disconnect', =>
            @alertService.error 'server disconnected...'

    showController: () ->
        return (@infos in ['page', 'view', 'component'])

    setType: (@infos) ->
        @controller = if (@infos isnt @controller) and (@infos in ['controller','page','view','component']) then true else false

    setName: () ->
        @slug = "/#{@name.toLowerCase()}"
        if @name.length > 1
            @cname = @name[0].toUpperCase() + @name.substring(1).toLowerCase() + 'Ctrl'
        else
            @cname = @name.toUpperCase() + 'Ctrl'
        @calias = @name.toLowerCase()

    create: ->
        unless @name
            @type = 'error'
            @message = "Define a #{@infos} name."
            return false

        if @name.length < 2
            @type = 'error'
            @message = "Name must be greater than 2 chars."
            return false
        
        # Avoid dir traversal
        unless /^[a-z0-9_]+$/.test(@name.toLowerCase())
            @type = 'error'
            @message = "#{@infos} name is not valid."
            return false

        if @name in ['angular','styles','assets','class','function','var']
            @type = 'error'
            @message = "#{@infos} name is forbidden."
            return false

        if (@infos is 'view') and !@state
            @type = 'error'
            @message = "Please select a parent state."
            return false

        # Reset error message
        @message = undefined

        options = {}
        options.name = @name[0].toUpperCase() + @name.substring(1).toLowerCase()
        # If we build server side
        if @infos is 'service'
            options.alias = if @salias then @salias else options.name.toLowerCase()
        # On client side
        else
            options.authentified = @authentified.toString()
            options.state = if @state then @state.toLowerCase() else ''
            
            if @controller
                options.controller = if @cname then @cname else options.name
                options.alias = if @calias then @calias else options.controller.toLowerCase()
            

            options.slug = if @slug then @slug else @name

        @devSocket.emit @infos, options
    

angular.module('webapp').controller 'DevCtrl', DevCtrl