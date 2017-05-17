require './app.routes'

angular.module('webapp')
    .run ($rootScope) ->
        $rootScope._ = window._
        return
    .run ($rootScope, $state, $location, Auth) ->
        $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState) ->
            shouldLogin = toState.data isnt undefined and toState.data.requireLogin and not Auth.isLoggedIn
          
            if shouldLogin
                $state.go('login')
                event.preventDefault()
                return

            if Auth.isLoggedIn
                shouldGoToMain = fromState.name is "" and toState.name

                if shouldGoToMain
                    $state.go(toState.name)
                    event.preventDefault()

                return
    .filter 'orderObjectBy', () ->
        (items, field, reverse) ->
            filtered = []
            angular.forEach items, (item) ->
                filtered.push item
            filtered.sort (a, b) ->
                (if a[field] > b[field] then 1 else -1)
            filtered.reverse()  if reverse
            filtered