# Extends ui-sref directive for firefox support
# Based on work of https://github.com/homerjam/angular-ui-sref-fastclick

angular.module('webapp')
    .directive 'uiSref', ($document) ->
        restrict: 'A'
        priority: 999
        link: ($scope, $element, $attrs) ->
            boundary = 10
            tapDelay = 200
            touchMove = (e) ->
                if (Math.abs(e.targetTouches[0].pageX - touchStartX) > boundary) or (Math.abs(e.targetTouches[0].pageY - touchStartY) > boundary)
                    trackTouch = false
            $document.on 'touchMove', touchMove
            $element.on '$destroy', ->
                $document.off "touchmove", touchMove
            $element.bind 'touchstart', (e) ->
                if e.targetTouches.length > 1
                    return
                touchTarget = e.target
                touchStartX = e.targetTouches[0].pageX
                touchStartY = e.targetTouches[0].pageY
                trackTouch = true

                if (e.timeStamp - lastClickTime) < tapDelay
                    e.preventDefault()
            $element.bind 'touchend', (e) ->
                unless trackTouch
                    return false
                if e.target isnt touchTarget
                    return false
                if (Math.abs(e.changedTouches[0].pageX - touchStartX) > boundary) or (Math.abs(e.changedTouches[0].pageY - touchStartY) > boundary)
                    return false
                lastClickTime = e.timeStamp
                $element.triggerHandler 'click'
                e.preventDefault()
