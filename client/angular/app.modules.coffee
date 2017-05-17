angular = require 'angular'
# <%Start requires %>
require 'angular-ui-router'
require 'angular-touch'
require 'angular-animate'
require 'angular-tooltips'
require 'angular-dnd-module'
# <%End requires %>

angular
    .module('webapp', [
        # <%Start modules %>
        'ui.router',
        'ngTouch',
        'ngAnimate',
        'dnd',
        '720kb.tooltips'
        # <%End modules%>
    ])