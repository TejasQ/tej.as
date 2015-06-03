app = angular
.module('tejas', ['ngAnimate', 'ui.router'])
.run(($timeout) ->
  $timeout(->
    FastClick.attach(document.body)))
.directive('expandLetter', ($timeout) ->
  return {
    link: (scope, element, attrs) ->
      $timeout( ->
        angular.element(element).addClass('expanded') )})
.directive('layer', ($timeout) ->
  return {
    link: (scope, element, attrs) ->
      jQuery(element).bind('click', ->
        if jQuery('#layers').hasClass('transformed')
          $timeout(->
            scope.open_layer(attrs.layer)))})
.controller('site', ($scope, $sce) ->

  $scope.loaded = true;
  
  $scope.layer = { active: 'home' }
  $scope.layers = { open: false }
  
  $scope.sections = ['home', 'work', 'music', 'personal', 'contact']
  
  $scope.open_layer = (layer) ->
    
    if $scope.layers.open
      $scope.layers.open = false
    else
      $scope.layers.open = true
      
    $scope.layer.active = $scope.sections[layer]

    $scope.technologies = [
      {
        slug: 'html',
        text: $sce.trustAsHtml('<code>&lt;p&gt;This is essential.<br>I learned HTML4 when I was 8 years old and seamlessly upgraded when the HTML5 came out.&lt;/p&gt;</code>') },
      {
        slug: 'jade',
        text: $sce.trustAsHtml("<code>html<br>&nbsp;&nbsp;head<br>&nbsp;&nbsp;&nbsp;&nbsp;title I love this.<br>&nbsp;&nbsp;body<br>&nbsp;&nbsp;&nbsp;&nbsp;p Hello<br>&nbsp;&nbsp;&nbsp;&nbsp;p My name is Tejas</code>") },
      {
        slug: 'css',
        text: $sce.trustAsHtml("<code class='dance'>animation: dance 2s ease infinite;</code>") },
      {
        slug: 'sass',
        text: $sce.trustAsHtml("<code>$soAreVariables: rgba(white, 0.5);<br><br>.nesting {<br>&nbsp;&nbsp;.is-cool {<br>&nbsp;&nbsp;&nbsp;&nbsp;color: <br>&nbsp;&nbsp;&nbsp;&nbsp;$soAreVariables; } }</code>") },
      {
        slug: 'foundation',
        text: $sce.trustAsHtml("<code>&lt;div class='row'&gt;<br>&nbsp;&nbsp;&lt;div class='small-6 medium-4 large-2 columns'&gt;Sup, columns?&lt;/div&gt;<br>&nbsp;&nbsp;&lt;div class='small-6 medium-4 large-2 columns'&gt;Foundation in tha house.&lt;/div&gt;<br>&lt;/div&gt;</code>") },
      {
        slug: 'bootstrap',
        text: $sce.trustAsHtml("<code>&lt;div class='col-sm-6 col-md-4 col-lg-2'>Sup, columns? Bootstrap in tha house.&lt;/div&gt;</code>") },
      {
        slug: 'js',
        text: $sce.trustAsHtml("<code>var tejas = { <br>&nbsp;&nbsp;race: 'indian', <br>&nbsp;&nbsp;loves: 'people, code', <br>&nbsp;&nbsp;eats: 'food', <br>&nbsp;&nbsp;sleep: function(){ <br>&nbsp;&nbsp;&nbsp;&nbsp;throw 'too busy,<br>&nbsp;&nbsp;&nbsp; cannot!'; } <br>};</code>") },
      {
        slug: 'angularjs',
        text: $sce.trustAsHtml("<code>var myApp = angular.module('myapp', ['ngAnimate', 'ui.router']);</code>") },
      {
        slug: 'jquery',
        text: $sce.trustAsHtml("<code>$(document).ready(<br>function(){<br>&nbsp;&nbsp;//DOM manipulation is cool!<br>});</code>") },
      {
        slug: 'coffeescript',
        text: $sce.trustAsHtml("<code>forcedIndents = 'sometimes annoying'<br><br>implicitReturns = 'Also sometimes annoying'<br><br>arrowFunctions = -> <br>&nbsp;&nbsp;'Cool!'</code>") },
      {
        slug: 'git',
        text: $sce.trustAsHtml("<code>git init<br>git add .<br>git commit -am 'Version control is the best.'</code>") },
      {
        slug: 'grunt',
        text: $sce.trustAsHtml("<code>grunt cssmin uglify</code>") },
      {
        slug: 'nodejs',
        text: $sce.trustAsHtml("<code>var http = require('http');<br><br>var server = http.createServer(<br>(request, response) =><br>&nbsp;&nbsp;response.writeHead(200, {'Content-Type': 'text/plain'});<br> });</code>") },
      {
        slug: 'php',
        text: $sce.trustAsHtml("<code>&lt;php<br>&nbsp;&nbsp;echo 'This is cool. I learned this in 2008.';<br>?&gt;</code>") },
      {
        slug: 'mysql',
        text: $sce.trustAsHtml("<code>SELECT `developer` FROM `developers` WHERE `skills` = 'so good'; #Find Tejas.</code>") }])