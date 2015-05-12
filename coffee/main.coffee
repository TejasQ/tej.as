debounce = (func, wait, immediate) ->
  timeout = undefined
  return ->
    context = this
    args = arguments
    later = ->
      timeout = null
      if !immediate
        func.apply context, args
      return

    callNow = immediate and !timeout
    clearTimeout(timeout)
    timeout = setTimeout(later, wait)
    if callNow
      func.apply(context, args)

calculateDistance = (elem, mouseX, mouseY) ->
  {
    x: Math.floor(Math.sqrt((mouseX - (elem.offset().left + elem.width() / 2)) ** 2))
    y: Math.floor(Math.sqrt((mouseY - (elem.offset().top + elem.height() / 2)) ** 2))
  }

FastClick.attach(document.body);
  
app = angular
.module('tejas', ['ngAnimate', 'ui.router'])

.directive('expandLetter', ($timeout) ->
  return {
    link: (scope, element, attrs) ->
      $timeout( ->
        angular.element(element).addClass('expanded')
      , 2300)
  }
)

.directive('layer', ->
  return {
    link: (scope, element, attrs) ->
      
      jQuery(element).bind('click', ->
        
        scope.$apply(->
          if jQuery('.layers').hasClass('transformed')
            scope.open_layer(attrs.layer)
        )
      )
  }
)

.directive('moveTheLayers', ->
  return {
    link: (scope, element, attrs) ->
      
      jQuery(element).bind('touchstart', (e) ->
        
        scope.$apply(->
          $('.layers.transformed').css('transition-timing-function', 'ease')
        )
      )
      
      jQuery(element).bind('touchmove', (e) ->
        
        debounce(scope.$apply(->
          $('.layers.transformed').css('transform', 'translateX(-70px) translateY(-50%) rotateX('+e.originalEvent.touches[0].screenY/10+'deg) rotateY('+e.originalEvent.touches[0].screenX/10+'deg) rotateZ(20deg) skew(-11deg, 0deg)')
        ), 250)
      )
    
      mousemove = (e) ->
          distance = calculateDistance($(e.originalEvent.srcElement), e.clientX, e.clientY)
          distance = distance.x
          if distance > 50
            scope.$apply(->
              $('.layers.transformed').css('perspective', distance+'px')
            )
      
      jQuery(element).on('mousemove', mousemove)
  }
)

.directive('swipeNav', ->
  return {
    link: (scope, element, attrs) ->
      
      touchstart = undefined
      $(element).bind('touchstart dragstart', (e) ->
        touchstart = e.originalEvent.changedTouches[0].clientX)
      
      $(element).bind('touchend dragend', (e) ->
        touchend = e.originalEvent.changedTouches[0].clientX
        difference = touchend - touchstart
        
        if difference > 100
          
          index = scope.sections.indexOf(scope.layer.active)
          
          if (index - 1 < 0)
            next = scope.sections[scope.sections.length - 1]
          else
            next = scope.sections[index-1]
            
          scope.$apply(->
            scope.layer.active = next
          )
          
        else if difference < -100
          index = scope.sections.indexOf(scope.layer.active)
          
          if (index + 1 >= scope.sections.length)
            next = scope.sections[0]
          else
            next = scope.sections[index+1]
            
          scope.$apply(->
            scope.layer.active = next
          )
      )
  }
)

.controller('site', ($scope, $sce) ->
  
  $scope.layer = { active: 'home' }
  $scope.layers = { open: false }
  
  $scope.sections = ['home', 'work', 'music', 'personal', 'contact']
  
  $scope.open_layer = (layer) ->
    
    console.log($scope.layers.open)
    if $scope.layers.open
      $scope.layers.open = false
    else
      $scope.layers.open = true
      
    $scope.layer.active = $scope.sections[layer]

    $scope.technologies = [
      {
        slug: 'html',
        text: $sce.trustAsHtml('<code>&lt;p&gt;This is essential.<br>I learned HTML4 when I was 8 years old and seamlessly upgraded when the HTML5 came out.&lt;/p&gt;</code>')
      },
      {
        slug: 'jade',
        text: $sce.trustAsHtml("<code>html<br>&nbsp;&nbsp;head<br>&nbsp;&nbsp;&nbsp;&nbsp;title I love this.<br>&nbsp;&nbsp;body<br>&nbsp;&nbsp;&nbsp;&nbsp;p Hello<br>&nbsp;&nbsp;&nbsp;&nbsp;p My name is Tejas</code>")
      },
      {
        slug: 'css',
        text: $sce.trustAsHtml("<code>animation: dance .6s infinite;</code><br><div class='dancer'></div>")
      },
      {
        slug: 'sass',
        text: $sce.trustAsHtml("<code>$soAreVariables: rgba(white, 0.5);<br><br>.nesting {<br>&nbsp;&nbsp;.is-cool {<br>&nbsp;&nbsp;&nbsp;&nbsp;color: <br>&nbsp;&nbsp;&nbsp;&nbsp;$soAreVariables; } }</code>")
      },
      {
        slug: 'foundation',
        text: $sce.trustAsHtml("<code>&lt;div class='row'&gt;<br>&nbsp;&nbsp;&lt;div class='small-6 medium-4 large-2 columns'&gt;Sup, columns?&lt;/div&gt;<br>&nbsp;&nbsp;&lt;div class='small-6 medium-4 large-2 columns'&gt;Foundation in tha house.&lt;/div&gt;<br>&lt;/div&gt;</code>")
      },
      {
        slug: 'bootstrap',
        text: $sce.trustAsHtml("<code>&lt;div class='col-sm-6 col-md-4 col-lg-2'>Sup, columns? Bootstrap in tha house.&lt;/div&gt;</code>")
      },
      {
        slug: 'js',
        text: $sce.trustAsHtml("<code>var tejas = { <br>&nbsp;&nbsp;race: 'indian', <br>&nbsp;&nbsp;loves: 'people, code', <br>&nbsp;&nbsp;eats: 'food', <br>&nbsp;&nbsp;sleep: function(){ <br>&nbsp;&nbsp;&nbsp;&nbsp;throw 'too busy,<br>&nbsp;&nbsp;&nbsp; cannot!'; } <br>};</code>")
      },
      {
        slug: 'angularjs',
        text: $sce.trustAsHtml("<code>var myApp = angular.module('myapp', ['ngAnimate', 'ui.router']);</code>")
      },
      {
        slug: 'jquery',
        text: $sce.trustAsHtml("<code>$(document).ready(<br>function(){<br>&nbsp;&nbsp;//DOM manipulation is &nbsp;&nbsp;cool!<br>});</code>")
      },
      {
        slug: 'coffeescript',
        text: $sce.trustAsHtml("<code>forcedIndents = 'sometimes annoying'<br><br>implicitReturns = 'Also sometimes annoying'<br><br>arrowFunctions = -> <br>&nbsp;&nbsp;'Cool!'</code>")
      },
      {
        slug: 'git',
        text: $sce.trustAsHtml("<code>git init<br>git add .<br>git commit -am 'Version control is the best.'</code>")
      },
      {
        slug: 'grunt',
        text: $sce.trustAsHtml("<code>grunt cssmin uglify</code>")
      },
      {
        slug: 'nodejs',
        text: $sce.trustAsHtml("<code>var http = require('http');<br><br>var server = http.createServer(<br>(request, response) =><br>&nbsp;&nbsp;response.writeHead(200, {'Content-Type': 'text/plain'});<br> });</code>")
      },
      {
        slug: 'php',
        text: $sce.trustAsHtml("<code>&lt;php<br>&nbsp;&nbsp;echo 'This is cool. I learned this in 2008.';<br>?&gt;</code>")
      },
      {
        slug: 'mysql',
        text: $sce.trustAsHtml("<code>SELECT `developer` FROM `developers` WHERE `skills` = 'so good'; #Find Tejas.</code>")
      }
    ])